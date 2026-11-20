# Validation results

All links 1 ms, initiator 0 unless stated. Expected values were written before running.

| Test | Network | Initiator | Expected | Observed | Result |
|---|---|---|---|---|---|
| V1 | Single | 0 | 0 sent, 1/1 informed, no error | sent=0, informed=1, t=0 s | PASS |
| V2 | Line6 | 0 | 5 sent, 0 dup, 6/6 informed, 5 ms | sent=5, received=5, dup=0, informed=6, 5 ms | PASS |
| V3 | Tree7 | 0 | 6 sent, 0 dup, 7/7 informed, 2 ms | | |
| V4 | Ring4 | 0 | 4 sent, 1 dup, 4/4 informed, 2 ms | | |
| V5 | Cyclic6 | 0 | (from hand trace) | | |
| V6 | Line6 | 0 / 2 / 5 | 5 sent each, last arrival 5 / 3 / 5 ms | | |
| V7 | Gaps | 0 | 1 sent, 2/2 informed, 1 ms | | |



