#!/bin/bash

# check if $MASTER_IP is there, if not then throw error
if [ -z "$MASTER_IP" ]; then
  echo "Error: MASTER_IP is not set."
  exit 1
fi

# fetch the kubeadm-config.yml file
# find more about the kubeadm config file here https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/
wget -O - kubeadm-config.yml https://raw.githubusercontent.com/andrew-the-drawer/k8s-local/refs/heads/main/kubeadm/kubeadm-config.yml > ./kubeadm-config.yml
# replace all "<IP-OF-ENP0S2>" with $MASTER_IP
sed -i "s/<IP-OF-ENP0S2>/$MASTER_IP/g" ./kubeadm-config.yml

# Run `kubeadm init`
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$MASTER_IP --config=./kubeadm-config.yml
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel CNI, our custom version
kubectl apply -f https://raw.githubusercontent.com/andrew-the-drawer/k8s-local/refs/heads/main/kubeadm/kube-flannel.yml
