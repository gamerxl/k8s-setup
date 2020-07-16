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
