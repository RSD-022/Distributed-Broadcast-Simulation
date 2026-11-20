package validation;

import Node3;
import Link;

network Line6
{
    submodules:
        node[6]: Node3;

    connections:
        for i=0..4 {
            node[i].gate++ <--> Link <--> node[i+1].gate++;
        }
}
