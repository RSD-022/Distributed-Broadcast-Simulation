# Validation results

All links 1 ms, initiator 0 unless stated. Expected values were written before running; the hand traces behind V3–V7 are in [hand_traces.md](hand_traces.md).

Run the whole suite from the repository root with `scripts/run_validation.sh` (after `source ~/omnetpp-6.3.0/setenv` and `make`), then copy each summary line into the Observed column. In every run, sent must equal received because there is no message loss.

| Test | Network | Initiator | Expected | Observed | Result |
|---|---|---|---|---|---|
| V1 | Single | 0 | 0 sent, 1/1 informed, no error | sent=0, informed=1, t=0 s | PASS |
| V2 | Line6 | 0 | 5 sent, 0 dup, 6/6 informed, 5 ms | sent=5, received=5, dup=0, informed=6, 5 ms | PASS |
| V3 | Tree7 | 0 | 6 sent, 6 received, 0 dup, 7/7 informed, 2 ms | sent=6, received=6, dup=0, informed=7, 2 ms | PASS |
| V4 | Ring4 | 0 | 4 sent, 4 received, 1 dup, 4/4 informed, 2 ms | sent=4, received=4, dup=1, informed=4, 2 ms | PASS |
| V5 | Cyclic6 | 0 | 8 sent, 8 received, 3 dup, 6/6 informed, 3 ms | sent=8, received=8, dup=3, informed=6, 3 ms | PASS |
| V6 | Line6 | 0 / 2 / 5 | 5 sent, 0 dup, 6/6 informed in each run; last arrival 5 / 3 / 5 ms | each run: sent=5, received=5, dup=0, informed=6; 5 / 3 / 5 ms | PASS |
| V7 | Gaps | 0 | 1 sent, 1 received, 0 dup, 2/2 informed, 1 ms, no error | sent=1, received=1, dup=0, informed=2, 1 ms, no error | PASS |

V3–V7 were run on 2026-11-21 with OMNeT++ 6.4.0. All seven tests pass.



