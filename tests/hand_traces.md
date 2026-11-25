# Hand traces for the validation suite

All links are 1 ms and node 0 is the initiator unless stated. `Z` is the control set carried by the message. A node's neighbour list follows its gate order, which is the order of the connection lines in the NED file. A node forwards only to neighbours that are missing from the `Z` it received, after adding them to `Z`. Every copy after the first is a duplicate and is dropped.

The counts below do not depend on the order in which simultaneous events are processed.

## V3 Tree7

Edges: 0-1, 0-2, 1-3, 1-4, 2-5, 2-6.

| t | Event | Z sent | Sent |
|---|---|---|---|
| 0 ms | 0 starts and sends to 1 and 2 | {0,1,2} | 2 |
| 1 ms | 1 receives, missing 3 and 4, sends to both | {0,1,2,3,4} | 2 |
| 1 ms | 2 receives, missing 5 and 6, sends to both | {0,1,2,5,6} | 2 |
| 2 ms | leaves 3, 4, 5 and 6 receive; their only neighbour is in Z | none | 0 |

Total: 6 sent, 6 received, 0 duplicates, 7/7 informed, last first reception 2 ms.

## V4 Ring4

Edges: 0-1, 1-2, 2-3, 3-0.

| t | Event | Z sent | Sent |
|---|---|---|---|
| 0 ms | 0 sends to 1 and 3 | {0,1,3} | 2 |
| 1 ms | 1 receives, missing 2, sends to 2 | {0,1,3,2} | 1 |
| 1 ms | 3 receives, missing 2, sends to 2 | {0,1,3,2} | 1 |
| 2 ms | 2 receives the first copy; neighbours 1 and 3 are in Z, sends nothing | none | 0 |
| 2 ms | 2 receives the second copy, a duplicate | none | 0 |

Total: 4 sent, 4 received, 1 duplicate (at node 2), 4/4 informed, last first reception 2 ms.

## V5 Cyclic6

Edges, in NED order: 0-1, 0-2, 1-3, 2-4, 3-4, 3-5, 4-5.
Neighbour lists: 0 {1,2}, 1 {0,3}, 2 {0,4}, 3 {1,4,5}, 4 {2,3,5}, 5 {3,4}.

| t | Event | Z sent | Sent |
|---|---|---|---|
| 0 ms | 0 sends to 1 and 2 | {0,1,2} | 2 |
| 1 ms | 1 receives, missing 3, sends to 3 | {0,1,2,3} | 1 |
| 1 ms | 2 receives, missing 4, sends to 4 | {0,1,2,4} | 1 |
| 2 ms | 3 receives, missing 4 and 5, sends to both | {0,1,2,3,4,5} | 2 |
| 2 ms | 4 receives, missing 3 and 5, sends to both | {0,1,2,4,3,5} | 2 |
| 3 ms | 4 receives from 3, a duplicate | none | 0 |
| 3 ms | 3 receives from 4, a duplicate | none | 0 |
| 3 ms | 5 receives its first copy; 3 and 4 are already in Z, sends nothing | none | 0 |
| 3 ms | 5 receives its second copy, a duplicate | none | 0 |

Total: 8 sent, 8 received, 3 duplicates (at nodes 3, 4 and 5), 6/6 informed, last first reception 3 ms.

Nodes 3 and 4 send to each other at the same time because each branch carries its own Z, and neither branch knows the other one has already reached the other node. This is the same effect as nodes 5 and 8 in Network3.

## V6 Line6, three initiators

Edges: 0-1, 1-2, 2-3, 3-4, 4-5. Run once with each initiator.

| Initiator | Trace | Sent | Last first reception |
|---|---|---|---|
| 0 | 0→1→2→3→4→5 | 5 | 5 ms (node 5) |
| 2 | 2→1→0 and 2→3→4→5 | 2 + 1 + 1 + 1 = 5 | 3 ms (node 5); node 0 is informed at 2 ms |
| 5 | 5→4→3→2→1→0 | 5 | 5 ms (node 0) |

All three runs: 0 duplicates, 6/6 informed. The number of messages stays the same, but the dissemination time follows the initiator's eccentricity (5, 3, 5). This is a small-scale check of H3.

## V7 Gaps

Two nodes with 3 gates each. Only `node[0].gate[2] <--> node[1].gate[0]` is connected.

| t | Event | Sent |
|---|---|---|
| 0 ms | 0 skips unconnected gates 0 and 1, finds neighbour 1 on gate 2, sends Z={0,1} on gate 2 | 1 |
| 1 ms | 1 receives on gate 0; its only neighbour, 0, is in Z, so it sends nothing | 0 |

Total: 1 sent, 1 received, 0 duplicates, 2/2 informed, last first reception 1 ms, no runtime error. Before the gate fix, node 0 would have sent on gate 0 (the neighbour's position instead of the real gate index) or crashed on an unconnected gate.
