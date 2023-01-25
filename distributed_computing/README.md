# Distributed comuting analyses of ecoacoustic audio files

#### Architecture

1. Replica node opens up server exposing it's api endpoint for analyses
2. Master finds all audio recordings in a site
    * If replica is ready, send a new analysis to the replica
    * If not, itterate to the next node and start new analysis on the new node

---

#### How to use
Edit `config.json` on the primary server to contain the ip addresses of the relica servers  
  
_Note: The primary server can be used as an analysis server using the loopback address and the order of the nodes are important, it specifies the priority of the nodes to run an analysis job._

**To start Primary Node:**  
run `$ ./start_distributed_primary.sh`  

**To start Replica Nodes:**  
run `$ ./start-server.sh`
