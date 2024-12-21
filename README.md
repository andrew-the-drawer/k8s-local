# K8s Local setup (with 2 more different machines)

## Notes

I enjoyed using [kind](https://kind.sigs.k8s.io/), but since I have 2 Macbooks at home (one is my personal computer, the other is sort of another personal/work computer), so why not trying to set up with [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/)

## Setup

### With kubeadm

Since I'm using Mac, I will use [multipass](https://canonical.com/multipass/install) to set up kubernetes cluster on bare metal. Way cooler 🎉

Firs thing first, make sure 2 computers are connecting to the same LAN. Set up bridge network for `multipass`:

```shell
$ multipass networks # list all network interface
# figure out what is the network interface
$ multipass set local.bridged-network=en0 # the LAN interface name
```

Start `multipass` with 2 CPUs, 2GB RAM and 10 GB disk storage. Make sure to enable the bridge network connection.

Connect to the shell

```shell
$ multipass shell <vm-name>
```

Do installation in the VMs:

```shell
$ wget -O - https://raw.githubusercontent.com/andrew-the-drawer/k8s-local/refs/heads/main/kubeadm/prepare.sh | bash
```

Please note down the VM public IP address in multipass GUI, then run the setup for master node

```shell
$ export MASTER_IP=<public-ip-of-VM>
$ wget -O - https://raw.githubusercontent.com/andrew-the-drawer/k8s-local/dcf8671f0339e66d2dca0c04782a336e337900bb/kubeadm/master.sh | bash
```

The output after running `master.sh` script in master VM will contain a `kubeadm join` script. Copy and run that in the worker VM (in another computer).

```shell
kubeadm join <master-ip>:6443 --token ... --discovery-token-ca-cert-hash ...
```