package validation;

import Node3;
import Link;

//
// V4: ring 0-1-2-3-0. The two branches from node 0 both reach node 2,
// so node 2 receives one duplicate.
//
network Ring4
{
    submodules:
        node[4]: Node3;

    connections:
        for i=0..3 {
            node[i].gate++ <--> Link <--> node[(i+1)%4].gate++;
        }
}
