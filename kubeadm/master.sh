#!/bin/bash

# Read input from the user (interactively) which is the public IP address of the master node
if [ -t 0 ]; then
  read -p "Enter the public IP address of the master node: " MASTER_IP
else
  echo "Enter the public IP address of the master node: "
  read MASTER_IP
fi

# Run `kubeadm init` with that IP address
# the `--pod-network-cidr` is always 10.224.0.0/16 as it is required for Flannel CNI (0.26.2) default config
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$MASTER_IP
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel CNI, version 0.26.2 (latest at that time)
kubectl apply -f https://github.com/flannel-io/flannel/releases/download/v0.26.2/kube-flannel.yml
