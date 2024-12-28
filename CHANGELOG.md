# Changelog

## v1.1.3 (AddressBindKubelet edition)
- Bind the address of kubelet to enp0s2
- Restart the containerd after system change (small fix for prepare.sh script)

## v1.1.2 (FlannelFix edition)
- Fix the kube-flannel link

## v1.1.1 (FlannelInterface edition)
- Use a customized network interface enp0s2 (LAN interface) to allow worker node connectivity via public LAN IP address

## v1.1.0 (KubeConfig edition)
- Add config copy guide

## v1.0.2 (KubeadmFix edition)
- Add sudo when call systemctl

## v1.0.1 (Kubeadm edition)
- Kubeadm full scripts and guides

## v1.0.0 (Init edition)
- Kubeadm script setup using K8s 1.32 for Ubuntu