# k3s-innit
Script to start your own k3s cluster with ease.

## Functions:
- Install k3s master.
- Install k3s worker.
- (Optional) Install portainer

## Help
run k3s-init.sh -h

  Run this script as root!
  usage:
  k3s-init.sh [master/worker]
  k3s-init.sh master ["portainer"]
  master: 
    - Runs package install.
    - Installs k3s.
    - Shows master key and master IP (needed for workers).
    - Optional: install portainer.
  k3s-init worker [IP of master] [KEY]
    worker:
    - Installs packages.
    - Instals k3s.
    - Connects to cluster.
