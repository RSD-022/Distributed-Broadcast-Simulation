# Failure test results

This suite checks pre-broadcast crashes and message loss on Line6 at commit `4230e90` using OMNeT++ 6.3.0 in Cmdenv.

All links are 1 ms and node 0 is the initiator. Expected values were written before running the tests. Counts are totals across all nodes, and `T` is the last first-reception time among informed nodes.

| Test | Network | Settings | Expected | Observed | Result |
| --- | --- | --- | --- | --- | --- |
| F1 (`F7_NoFailures`) | Line6 | `p=0`, `q=0` | 5 sent, 5 received, 0 lost, 0 crashed, 6/6 informed, `T=5 ms` | sent=5, received=5, lost=0, crashed=0, informed=6, `T=5 ms` | PASS |
| F2 (`F7_AllLost`) | Line6 | `p=0`, `q=1` | 1 sent, 0 received, 1 lost, 0 crashed, 1/6 informed, `T=0 ms` | sent=1, received=0, lost=1, crashed=0, informed=1, `T=0 ms` | PASS |
| F3 (`F7_AllCrashed`) | Line6 | `p=1`, `q=0` | 1 sent, 1 received, 0 lost, 5 crashed, 1/6 informed, `T=0 ms` | sent=1, received=1, lost=0, crashed=5, informed=1, `T=0 ms` | PASS |
| F4 (`F7_MiddleCrash`) | Line6 | Only node 2 crashes, `q=0` | 2 sent, 2 received, 0 lost, 1 crashed, 2/6 informed, `T=1 ms` | sent=2, received=2, lost=0, crashed=1, informed=2, `T=1 ms` | PASS |

All four runs had zero duplicate arrivals and satisfied `sent = received + lost`.

## Baseline check

From the repository root, run this command to compare all eight per-node scalars for each of the 20 `p=0` runs and 20 `q=0` runs with the 1 ms Geant case from `C2_Delay`. The comparison uses node and scalar names as keys, so run IDs and row order can differ.

```bash
python3 - <<'PY'
import csv
from collections import defaultdict
from pathlib import Path

processed = Path("results/processed")

with (processed / "C2_Delay.csv").open(newline="") as file:
    baseline = {
        (row["module"], row["name"]): row["value"]
        for row in csv.DictReader(file)
        if row["net"] == "real.Geant" and float(row["d"]) == 1
    }
assert len(baseline) == 22 * 8

for config, probability in [("C4_Crash", "p"), ("C4_Loss", "q")]:
    runs = defaultdict(dict)
    with (processed / f"{config}.csv").open(newline="") as file:
        for row in csv.DictReader(file):
            if float(row[probability]) == 0:
                key = (row["module"], row["name"])
                runs[int(row["repetition"])][key] = row["value"]
    assert set(runs) == set(range(20)), config
    for repetition, scalars in runs.items():
        assert scalars == baseline, (config, repetition)

print("40/40 runs identical to C2_Delay d=1 Geant")
PY
```

**Result.** 40/40 runs identical to C2_Delay d=1 Geant.

## Interpretation

**Crash (`p=0.3`, repetition 12).** Ten of Geant's 22 nodes crashed. Removing them left 12 survivors, of which eight were still connected to initiator 0. Nodes 8, 11, 13 and 17 survived but were cut off. All eight reachable survivors became informed, so `coverageReachable = 8/8 = 1`, while `coverageAll = 8/22`.

**Loss (`q=0.2`, repetition 11).** All 22 nodes remained reachable, but only nodes 0, 8, 15 and 19 became informed. Node 0 added node 9 to `Z` when preparing its copies, and the copy addressed to node 9 was lost. Node 8 received the broadcast via node 19 with node 9 still in `Z`, so it skipped forwarding to its neighbor 9. This is why **“Z is a promise that loss can break”**: an ID can suppress another send after the promised delivery falls through. This run had seven sends, three arrivals and four losses.
