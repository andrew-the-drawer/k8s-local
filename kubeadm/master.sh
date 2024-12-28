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

# Install Flannel CNI, our custom version
kubectl apply -f https://raw.githubusercontent.com/andrew-the-drawer/k8s-local/refs/heads/main/kubeadm/kubeadm/kube-flannel.yml
