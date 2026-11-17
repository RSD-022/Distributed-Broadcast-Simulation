/*
 * Node3.cc
 * Original author: oudai
 */

#include <vector>
#include <limits>
#include <omnetpp.h>
#include "DiffuseMessage_m.h"

using namespace omnetpp;

class Node3 : public cSimpleModule
{
private:
    bool done = false;
    bool initiator = false;

    std::vector<int> N;

    // Fix 4: actual output gate corresponding to each neighbor.
    std::vector<int> outGate;

    // Fix 5: measurements.
    long sent = 0;
    long received = 0;
    long duplicates = 0;
    long zEntriesSent = 0;

    bool informed = false;
    simtime_t firstReception;

protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void finish() override;
};

Define_Module(Node3);


void Node3::initialize()
{
    // Fix 3: gateSize() works even when there are zero gates.
    int gateSizeOut = gateSize("gate$o");

    // Fixes 3 and 4: inspect only existing gates and retain their indices.
    for (int g = 0; g < gateSizeOut; g++) {
        cGate *nextGate = gate("gate$o", g)->getNextGate();

        if (nextGate != nullptr) {
            int neighborIndex =
                nextGate->getOwnerModule()->getIndex();

            N.push_back(neighborIndex);
            outGate.push_back(g);

            EV << "Neighbor " << neighborIndex
               << " uses output gate " << g << endl;
        }
    }

    // Fix 1: configurable initiator.
    initiator = par("initiator").boolValue();

    if (initiator) {
        // Fix 5: source is informed at simulation start.
        informed = true;
        firstReception = simTime();

        DiffuseMessage *msg =
            new DiffuseMessage("diffusion v3");

        msg->setInformation(2026);

        // Fix 2: explicitly append source and neighbor IDs.
        msg->appendZ(getIndex());

        for (int i = 0; i < N.size(); i++) {
            msg->appendZ(N[i]);
        }

        // Fix 4: send only through connected output gates.
        for (int k = 0; k < outGate.size(); k++) {
            // Fix 5: count each transmitted copy.
            sent++;
            zEntriesSent += msg->getZArraySize();

            send(msg->dup(), "gate$o", outGate[k]);
        }

        getDisplayString().setTagArg("i", 1, "red");
        done = true;

        delete msg;
    }
}


void Node3::handleMessage(cMessage *msg)
{
    // Fix 5: count every arrival, including duplicates.
    received++;

    if (done) {
        duplicates++;
    }

    if (!done) {
        // Fix 5: record only the first reception time.
        informed = true;
        firstReception = simTime();

        DiffuseMessage *receivedMsg =
            check_and_cast<DiffuseMessage *>(msg);

        int t = receivedMsg->getZArraySize();
        std::vector<int> missingZ;

        // Original logic: find neighbors absent from received Z.
        for (int i = 0; i < N.size(); i++) {
            bool existe = false;
            int j = 0;

            while (j < t && !existe) {
                if (receivedMsg->getZ(j) == N[i]) {
                    existe = true;
                }

                j++;
            }

            if (!existe) {
                missingZ.push_back(i);
            }
        }

        // Original logic: extend Z before sending copies.
        for (int k = 0; k < missingZ.size(); k++) {
            receivedMsg->appendZ(N[missingZ[k]]);
        }

        for (int k = 0; k < missingZ.size(); k++) {
            // Fix 5: count each transmitted copy.
            sent++;
            zEntriesSent += receivedMsg->getZArraySize();

            // Fix 4: translate neighbor position into actual gate index.
            send(
                receivedMsg->dup(),
                "gate$o",
                outGate[missingZ[k]]
            );
        }
    }

    getDisplayString().setTagArg("i", 1, "red");
    done = true;

    delete msg;
}


void Node3::finish()
{
    // Fix 5: write node-level results to the scalar output.
    recordScalar("sent", sent);
    recordScalar("received", received);
    recordScalar("duplicates", duplicates);
    recordScalar("zEntriesSent", zEntriesSent);
    recordScalar("informed", informed ? 1 : 0);

    // An uninformed node must not appear to receive at time zero.
    double arrivalTime = informed
        ? firstReception.dbl()
        : std::numeric_limits<double>::quiet_NaN();

    recordScalar("firstReceptionTime", arrivalTime, "s");
}
