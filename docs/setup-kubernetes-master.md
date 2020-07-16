# Setup a Kubernetes master with a Kubernetes Cluster

1. Execute the bash script below (follow-up guide: [Setup Kubernetes Kubeadm](docs/setup-kubernetes-kubeadm.md)) to prepare the Kubernetes Master Machine and install all needed tools to operate a Kubernetes Cluster. The bash script below needs to be executed on the Kubernetes Master Machine:

   `../scripts/setup-kubernetes-kubeadm.sh`

2. Execute the bash script below to create a Kubernetes Cluster on a Kubernetes Master Machine. The bash script below needs to be executed on the Kubernetes Master Machine:

   `../scripts/setup-kubernetes-master.sh`

## Bash Script

The bash script below creates a Kubernetes Cluster and needs to be executed on a Kubernetes Master Machine:

`../scripts/setup-kubernetes-master.sh`:

```bash
#!/bin/bash

# Enable noninteractive mode to suppress any interactive user prompt
export DEBIAN_FRONTEND=noninteractive

# Initialize the control-plane node and grep command for join of kubernetes nodes
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#initializing-your-control-plane-node
sudo kubeadm init --apiserver-advertise-address=192.168.200.2 --pod-network-cidr 10.244.0.0/16 2>/dev/null

# Make kubectl work for your current non-root user
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#more-information
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Installing a Pod network add-on
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml

```

### Explanations

The line below initializes a Kubernetes Cluster on a Kubernetes Master Machine:

```bash
sudo kubeadm init --apiserver-advertise-address=192.168.200.2 --pod-network-cidr 10.244.0.0/16 2>/dev/null
```

The first argument configures the external IP of the API-Endpoint:

```bash
--apiserver-advertise-address=192.168.200.2
```

The second argument configures the Network Block (CIDR-Block) for the internal Cluster Network of the Kubernetes Cluster. Each Kubernetes Pod get its own IP address in this Network Block and can communicate with each other:

```bash
--pod-network-cidr 10.244.0.0/16
```

It is recommended to set the second argument otherwise it will choose the IP of the first Network Interface (eth0) of the Kubernetes Master Machine. This can be troubling when the first Network Interface (eth0) of the Kubernetes Master Machine is intended only for external traffic like NATed Network Traffic. For instance this could be a real problem with Vagrant provisioned machines. Read more regarding this problem: [https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/#default-nic-when-using-flannel-as-the-pod-network-in-vagrant](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/#default-nic-when-using-flannel-as-the-pod-network-in-vagrant). In contrast to the documentation this problem is not only limited to the Flannel Network Plugin.

The next block below makes the Kubelet command `kubectl` to work for the current user.

```bash
# Make kubectl work for your current non-root user
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#more-information
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

The Kubelet command `kubectl` is a tool to manage the Kubernetes Cluster by CLI (Command line input):

Setup a CNI (Container Network Interface - read more: [https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/#cni](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/#cni)) implementing Network Plugin for the internal Cluster Network of the Kubernetes Cluster. For a production ready environment the Calico Network Plugin is recommended (more informations about alternatives and why it is recommended to choose the Calico Network Plugin instead of the alternatives is argued below):

```bash
# Installing a Pod network add-on
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
```

**Alternatives and why Calico:**

In principle the standard Kubenet Network Plugin can be chosen which is a very basic Network Plugin and for easy setups it does the job. Beside the standard Kubenet and Calico Network Plugin there are a few other plugins like the commonly chosen Flannel Network Plugin.

Read more: [https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network)

The Calico Network Plugin has some considerable arguments for why to choose it over its alternatives:

- Citing from Kubernetes documentation:

  > **Note:** Currently Calico is the only CNI plugin that the kubeadm project performs e2e tests against. If you find an issue related to a CNI plugin you should log a ticket in its respective issue tracker instead of the kubeadm or kubernetes issue trackers. 

- It has a powerful Network Policy based on Network Layer 3. It can be very granulate regulate how Kubernetes Pods can communicate with each other. This can be a key argument when security is in mind.

- It has a really good performance.

