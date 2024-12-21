#!/bin/bash

# check if $MASTER_IP is there, if not then throw error
if [ -z "$MASTER_IP" ]; then
  echo "Error: MASTER_IP is not set."
  exit 1
fi



# Run `kubeadm init` with that IP address
# the `--pod-network-cidr` is always 10.224.0.0/16 as it is required for Flannel CNI (0.26.2) default config
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$MASTER_IP
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel CNI, version 0.26.2 (latest at that time)
kubectl apply -f https://github.com/flannel-io/flannel/releases/download/v0.26.2/kube-flannel.yml
