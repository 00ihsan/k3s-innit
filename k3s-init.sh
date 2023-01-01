#! /bin/bash

help()
{
  echo "
  Run this script as root!
  usage:
  k3s-init.sh [master/worker]
  k3s-init.sh master [\"portainer\"]
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
  "
}

if [ "$EUID" -ne 0 ]; 
then
  echo "Please run as root"
  help
  exit
fi

if [ -z "$1" ]; 
then 
  help
  exit
fi

if [ $1 = 'h' ];
then
  help
  exit
fi

if [ $1 = '-h' ];
then
  help
  exit
fi

echo "Ihsansoft 2023"
echo "Hi!"
echo "Welcome! This script installs the basic stuff for ubuntu to get k3s 
to work!"

apt update -y
apt updrage -y
apt install net-tools -y
apt install curl -y

if [ $1 = "master" ]; then 
  echo "master mode"
  curl -sfL https://get.k3s.io | sh -
  echo "Key: "
  cat /var/lib/rancher/k3s/server/node-token
  echo "Master IP: $(ifconfig | grep -wv "127.0.0.1" | grep "inet " | awk '{ print $2}')"
  if [ -z "$2" ]; then 
    exit
  fi
  if [ $2 = "portainer" ]; then
    kubectl apply -n portainer -f https://raw.githubusercontent.com/portainer/k8s/master/deploy/manifests/portainer/portainer.yaml
    echo "Access portainer via https://$(ifconfig | grep -wv "127.0.0.1" | grep "inet " | awk '{ print $2}'):30779"
  fi
elif [ $1 = "worker" ]; then
  echo "worker mode"
  if [ -z "$2" ]; then 
  echo "No IP provided!"
  exit
  fi
  if [ -z "$3" ]; then 
  echo "No Key provided!"
  exit
  fi
  curl -sfL https://get.k3s.io | K3S_URL=https://$2:6443 K3S_TOKEN=$3 sh -
else
  echo "Unknown: $1"
  help
fi
