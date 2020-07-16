# Setup Kubernetes Kubeadm

Execute the bash script below to install all needed tools to operate a Kubernetes Cluster / Kubernetes Node Agent on Kubernetes Master and Kubernetes Node Agent Machines:

`../scripts/setup-kubernetes-kubeadm.sh`

## Bash Script

The bash script below installs all needed tools to operate a Kubernetes Cluster / Kubernetes Node Agents and needs to be executed on Kubernetes Master and Kubernetes Node Agent Machines:

`../scripts/setup-kubernetes-kubeadm.sh`:

```bash
#!/bin/bash

# Enable noninteractive mode to suppress any interactive user prompt
export DEBIAN_FRONTEND=noninteractive

# Letting iptables see bridged traffic
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#letting-iptables-see-bridged-traffic
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# Installing kubeadm, kubelet and kubectl
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
sudo apt-get update -y && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - &> /dev/null
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Restarting the kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

```

### Explanations

The block below prepares the Machine to letting iptables see bridged traffic:

```bash
# Letting iptables see bridged traffic
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#letting-iptables-see-bridged-traffic
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
```

However the block above is not explicit necessary, but very recommended for production environments.

The next block below install the CLI (Command Line Interface) tools `kubelet`, `kubeadm` and `kubectl` on the Machine and those are a needed to operate a Kubernetes Cluster or Kubernetes Node Agent:

```bash
# Installing kubeadm, kubelet and kubectl
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
sudo apt-get update -y && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - &> /dev/null
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Restarting the kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```
