package validation;

import Node3;
import Link;

//
// V7: gate vectors with unconnected entries (tests the safe-gate fix).
// Each node has 3 gates; only node[0].gate[2] <--> node[1].gate[1] is connected.
// Node3 must skip gates 0 and 2 of node 1 and gates 0 and 1 of node 0,
// and send through the real gate index, not the neighbour position.
//
network Gaps
{
    submodules:
        node[2]: Node3 {
            gates:
                gate[3];
        }

    connections allowunconnected:
        node[0].gate[2] <--> Link <--> node[1].gate[1];
}
