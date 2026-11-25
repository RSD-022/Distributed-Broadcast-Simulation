package validation;

import Node3;
import Link;

//
// V3: complete binary tree of depth 2, node i has children 2i+1 and 2i+2.
// No cycles, so Diffuse-v3 must produce zero duplicates.
//
network Tree7
{
    submodules:
        node[7]: Node3;

    connections:
        for i=0..2 {
            node[i].gate++ <--> Link <--> node[2*i+1].gate++;
            node[i].gate++ <--> Link <--> node[2*i+2].gate++;
        }
}
