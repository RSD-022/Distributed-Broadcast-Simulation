//
// Lab network: 9 nodes, 9 links, one cycle (1-2-8-5-4-1).
// Moved unchanged from the lab project; the Node3 type now lives in src/Node3.ned.
//
network Network3
{
    types:
        channel Channel extends ned.DelayChannel
        {
            delay = 100ms;
        }
    submodules:
        node[9]: Node3;
    connections:
        node[0].gate++ <--> Channel <--> node[1].gate++;
        node[1].gate++ <--> Channel <--> node[2].gate++;
        node[1].gate++ <--> Channel <--> node[4].gate++;
        node[3].gate++ <--> Channel <--> node[4].gate++;
        node[4].gate++ <--> Channel <--> node[5].gate++;
        node[4].gate++ <--> Channel <--> node[7].gate++;
        node[5].gate++ <--> Channel <--> node[8].gate++;
        node[2].gate++ <--> Channel <--> node[8].gate++;
        node[3].gate++ <--> Channel <--> node[6].gate++;
}
