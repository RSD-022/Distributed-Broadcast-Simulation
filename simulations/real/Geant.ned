//
// Geant topology from SNDlib
// Converted to OMNeT++ NED by Role C (Step 5)
//

package real;

import Node3;
import Link;

network Geant
{
    submodules:
        node[22]: Node3;

    connections allowunconnected:
        node[0].gate++ <--> Link <--> node[2].gate++;
        node[0].gate++ <--> Link <--> node[4].gate++;
        node[0].gate++ <--> Link <--> node[9].gate++;
        node[0].gate++ <--> Link <--> node[15].gate++;
        node[0].gate++ <--> Link <--> node[19].gate++;
        node[1].gate++ <--> Link <--> node[6].gate++;
        node[1].gate++ <--> Link <--> node[13].gate++;
        node[1].gate++ <--> Link <--> node[14].gate++;
        node[2].gate++ <--> Link <--> node[6].gate++;
        node[2].gate++ <--> Link <--> node[12].gate++;
        node[3].gate++ <--> Link <--> node[4].gate++;
        node[3].gate++ <--> Link <--> node[16].gate++;
        node[3].gate++ <--> Link <--> node[20].gate++;
        node[4].gate++ <--> Link <--> node[6].gate++;
        node[4].gate++ <--> Link <--> node[7].gate++;
        node[4].gate++ <--> Link <--> node[10].gate++;
        node[4].gate++ <--> Link <--> node[12].gate++;
        node[4].gate++ <--> Link <--> node[14].gate++;
        node[4].gate++ <--> Link <--> node[18].gate++;
        node[5].gate++ <--> Link <--> node[6].gate++;
        node[5].gate++ <--> Link <--> node[12].gate++;
        node[5].gate++ <--> Link <--> node[17].gate++;
        node[6].gate++ <--> Link <--> node[13].gate++;
        node[6].gate++ <--> Link <--> node[21].gate++;
        node[7].gate++ <--> Link <--> node[12].gate++;
        node[8].gate++ <--> Link <--> node[9].gate++;
        node[8].gate++ <--> Link <--> node[19].gate++;
        node[9].gate++ <--> Link <--> node[20].gate++;
        node[10].gate++ <--> Link <--> node[21].gate++;
        node[11].gate++ <--> Link <--> node[12].gate++;
        node[11].gate++ <--> Link <--> node[14].gate++;
        node[14].gate++ <--> Link <--> node[21].gate++;
        node[15].gate++ <--> Link <--> node[21].gate++;
        node[16].gate++ <--> Link <--> node[18].gate++;
        node[17].gate++ <--> Link <--> node[21].gate++;
        node[18].gate++ <--> Link <--> node[21].gate++;
}
