//
// Diffuse-v3 process. Moved unchanged from the lab project (Network3.ned),
// where it was declared in the same file as the network.
//
simple Node3
{
    parameters:
        @display("i=block/routing"); // add a default icon
    gates:
        inout gate[]; // declare two way connections multiple inout gates
}
