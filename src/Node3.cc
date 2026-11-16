
/*
 * Node3.cc
 *
 *  Created on: Oct 1, 2026
 *      Author: oudai
 */

#include <vector>
#include <string.h>
#include <omnetpp.h>
#include "DiffuseMessage_m.h"
using namespace omnetpp;
//notre classe Node hérite de la classe OMNeT++ :cSimpleModule
class Node3 : public cSimpleModule
{
private:
    bool done;
    bool initiator;
    std::vector<int>N; //tableau donne un ensemble sans les doulons
protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};
    Define_Module(Node3);//macro de simulateur
    //hadoo t3 l sp
   /* std::set<int> Node3::getNeighbors(){
        std::set<int> neighbors;
        for (int i=0;i<gateSize("gate$o");i++){
            cGate *out=gate("gate$o");
            cGate *dist=out->getPathEndGate();
            int neighbor=dist->getOwnerModule()->getIndex();
            neighbors.insert(neighbor);
        }
        return neighbors;
    }*/
    void Node3::initialize(){
           // fonction pour avoir les neighbors de lab0

        const char *gateName = "gate$o";  // Output gate name
         EV << "Initializing node " << getIndex() << endl;

         int gateSizeOut = gate(gateName, 0)->size();  // Get the number of gates
         EV << "Node " << getIndex() << " has " << gateSizeOut << " output gates" << endl;

         int i = 0;
         int neighborIndex;
         cGate *destGate = nullptr;

         // Get the list of my neighbors
         do {
             EV << "Checking gate " << i << " for neighbors" << endl;
             destGate = gate(gateName, i++);  // Get each gate
             cGate *nextGate = destGate->getNextGate();  // Get the next connected gate
             if (nextGate) {
                 neighborIndex = nextGate->getOwnerModule()->getIndex();  // Get the neighbor's index
                 N.push_back(neighborIndex);  // Store the neighbor's index
                 EV << "Found neighbor: " << neighborIndex << endl;
             } else {
                 EV << "No neighbor found on gate " << i - 1 << endl;
             }
         } while (i < gateSizeOut);  // Loop through all gates

         int myNeighborsSize = static_cast<int>(N.size());  // Number of neighbors

         // List my neighbors to check
         EV << "I'm node " << getIndex() << ", I have " << myNeighborsSize << " neighbor(s): ";
         for (const int& neighbor : N) {
             EV << neighbor << " ";
         }
         EV << "\n";
         ////////////////////////////////
         if (getIndex() ==0 ){
             initiator=true;
             DiffuseMessage *msg=new DiffuseMessage("diffusion v3");
             msg->setInformation(2026);
             msg->setZArraySize(N.size());
             msg->appendZ(0);
             for(int i=0;i<N.size();i++){
                 msg->setZ(i+1, N[i]);
                 EV << "Adding neighbor " << N[i] << " to message" << endl;
             }
             for (int i=0;i<gateSize("gate$o");i++){
                 send(msg->dup(),"gate$o",i);//faire un copie dup pour les voisins

             }
             getDisplayString().setTagArg("i", 1, "red");//le noeud a deja traite la diffusion
             done=true;
             delete msg;
             EV << "Message deleted after sending" << endl;

         }
         else{
             initiator=false;
             done=false;
         }

    }
    void Node3::handleMessage(cMessage *msg){
      EV << "Node " << getIndex() << " received a message" << endl;
       if(getIndex() != 0 && !done){
         EV << "Received message ' " << msg->getName() << "'" << endl;
          EV <<"Broadcasting" << endl;
          DiffuseMessage *receivedMsg=check_and_cast<DiffuseMessage*>(msg);
          EV << "Node " << getIndex()
             << " received a message with information: "
             << receivedMsg->getInformation()
             << endl;
          int t = receivedMsg->getZArraySize();
          std::vector<int> missingZ;

          // Chercher les voisins absents de Z
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
          for (int k = 0; k < missingZ.size(); k++) {
              receivedMsg->appendZ(N[missingZ[k]]);
          }
          for (int k = 0; k < missingZ.size(); k++) {
              send(receivedMsg->dup(),"gate$o",missingZ[k]);
          }
    }
    getDisplayString().setTagArg("i", 1, "red");//le noeud a deja traite la diffusion
    done = true;
    delete msg ;
    }





