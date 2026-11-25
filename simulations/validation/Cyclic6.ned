package validation;

import Node3;
import Link;

//
// V5: two branches from node 0 (0-1-3 and 0-2-4) joined by the cross link 3-4,
// both closing on node 5. Nodes 3 and 4 send to each other at the same time,
// like nodes 5 and 8 in Network3. Hand trace in tests/hand_traces.md.
//
network Cyclic6
{
    submodules:
        node[6]: Node3;

    connections:
        node[0].gate++ <--> Link <--> node[1].gate++;
        node[0].gate++ <--> Link <--> node[2].gate++;
        node[1].gate++ <--> Link <--> node[3].gate++;
        node[2].gate++ <--> Link <--> node[4].gate++;
        node[3].gate++ <--> Link <--> node[4].gate++;
        node[3].gate++ <--> Link <--> node[5].gate++;
        node[4].gate++ <--> Link <--> node[5].gate++;
}
