//
// Diffuse-v3 process.
//
simple Node3
{
    parameters:
        @display("i=block/routing"); // add a default icon
        bool initiator = default(false);
        double crashProb = default(0);
        double lossProb = default(0);
    gates:
        inout gate[]; // declare two way connections multiple inout gates
}
