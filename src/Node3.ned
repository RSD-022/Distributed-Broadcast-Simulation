//
// Diffuse-v3 process.
//
simple Node3
{
    parameters:
        @display("i=block/routing"); // add a default icon
        bool initiator = default(false);
    gates:
        inout gate[]; // declare two way connections multiple inout gates
}
