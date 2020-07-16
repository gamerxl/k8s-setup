# Kubernetes setup guide for production environments

The guide provides and explains some useful bash scripts to setup a production ready Kubernetes Cluster on machines running a <u>Debian based distro</u>. The setup does not make use of third party tools beside the tools provided by Kubernetes, Docker and co.. Most part of its sources is based on official documentation: [https://kubernetes.io/docs/setup/production-environment/](https://kubernetes.io/docs/setup/production-environment/)

It can be done by everyone with rudimentary knowledge working with Linux based systems. Still it is recommended to have already spent some time (or coffee - tee if you prefer) with the administration of multi-machine systems to fit the requirements from a technical and architectural view. In particular this is even more important if you going to run it for production environments.

The guide does not pick up how to setup machines or rather virtual machines and does not explain how to install a Debian based distro. The guide requires that the required machines already set up and have installed a Debian based distro.

The setup itself was done on machines with installed Ubuntu 20.04 LTS server distro.



## Guides

1. [Setup a Kubernetes Master Machine with a Kubernetes Cluster](docs/setup-kubernetes-master.md)
2. [Setup a Kubernetes Node Agent Machine](docs/setup-kubernetes-node-agent.md)



## Bash Scripts

- [setup-kubernetes-kubeadm.sh](scripts/setup-kubernetes-kubeadm.sh)
- [setup-kubernetes-master.sh](scripts/setup-kubernetes-master.sh)
- [setup-kubernetes-node-agent.sh](scripts/setup-kubernetes-node-agent.sh)



## Machine requirements

### Setup a standalone single Kubernetes Cluster

Setup a standalone single Kubernetes Cluster without any node agents. This setup can be useful as development setup. This setup is not recommended for production environments.

| Role              | CPU    | Memory                                        | Distro                 |
| ----------------- | ------ | --------------------------------------------- | ---------------------- |
| Kubernetes Master | 1 Core | Minimal recommended requirements are 2GB RAM. | Distro based on Debian |

### Setup a Kubernetes Cluster with one or more Node Agents

| Role                  | CPU    | Memory                                        | Distro                 |
| --------------------- | ------ | --------------------------------------------- | ---------------------- |
| Kubernetes Master     | 1 Core | Minimal recommended requirements are 2GB RAM. | Distro based on Debian |
| Kubernetes Node agent | 1 Core | Minimal recommended requirements are 1GB RAM. | Distro based on Debian |



## Glossary

| Wording               | Explanation                                                  |
| --------------------- | ------------------------------------------------------------ |
| Kubernetes            | Kubernetes is a Tool for distributed container orchestration.<br /><br />Read more: [https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/) |
| Kubernetes Master     | A Kubernetes Master controls a Kubernetes Cluster and manage joined Kubernetes Node agents. It self runs a Control Server also called "Control Plane" ([https://kubernetes.io/docs/concepts/overview/components/#control-plane-components](https://kubernetes.io/docs/concepts/overview/components/#control-plane-components)) with a public API-Endpoint ([https://kubernetes.io/docs/concepts/overview/components/#kube-apiserver](https://kubernetes.io/docs/concepts/overview/components/#kube-apiserver)). The Control Plane does manage the distributed creation, execution and deletion of Kubernetes Pods, Kubernets Services and Kubernetes Deployments on joined Kubernetes Node agents or whether on itself if configured to do so.<br /><br />Read more: [https://kubernetes.io/docs/concepts/overview/components/#control-plane-components](https://kubernetes.io/docs/concepts/overview/components/#control-plane-components) |
| Kubernetes Node agent | A Kubernetes Node agent operate Kubernetes Pods, Kubernetes Services and Kubernetes Deployments.<br /><br />Read more: [https://kubernetes.io/docs/concepts/overview/components/#node-components](https://kubernetes.io/docs/concepts/overview/components/#node-components) |
| Kubernetes Pod        | A Kubernetes Pod is a Container run by a Container Runtime which is implementing the CRI (Container Runtime Interface). Kubernetes supported Container Runtimes right now are Docker ([https://www.docker.com/](https://www.docker.com/)) and CRI implementing Container Runtimes like CRI-O ([https://cri-o.io/](https://cri-o.io/)), Containerd ([https://containerd.io/](https://containerd.io/)).<br /><br />Kubernetes Pod are the smallest unit and can be described like Docker containers.<br /><br />Read more: [https://kubernetes.io/docs/concepts/workloads/pods/pod/](https://kubernetes.io/docs/concepts/workloads/pods/pod/) |
| Kubernetes Service    | A Kubernetes Service expose Kubernetes Pods to the network or even external.<br /><br />Read more: [https://kubernetes.io/docs/concepts/services-networking/service/](https://kubernetes.io/docs/concepts/services-networking/service/) |
| Kubernetes Deployment | A Kubernetes Deployment describe the update and replication of Kubernetes Pods.<br /><br />Read more: [https://kubernetes.io/docs/concepts/workloads/controllers/deployment/](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) |
