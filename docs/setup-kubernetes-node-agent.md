# Setup a Kubernetes Node Agent

1. Execute the bash script below (follow-up guide: [Setup Kubernetes Kubeadm](docs/setup-kubernetes-kubeadm.md)) to prepare the Kubernetes Node Agent Machine and install all needed tools to operate a Kubernetes Node Agent. The bash script below needs to be executed on the Kubernetes Node Agent Machine:

   `../scripts/setup-kubernetes-kubeadm.sh`

2. Execute the bash script below to retrieve a needed join command for the Kubernetes Node Agent to join the Kubernetes Cluster. The bash script below needs to be executed on a Kubernetes Master Machine:

   `../scripts/setup-kubernetes-node-agent.sh`

3. Execute the retrieved join command on the Kubernetes Node Agent Machine.

## Bash Script

The bash script below needs retrieves a command for Kubernetes Node Agents to join the Kubernetes Cluster and needs to be executed on a Kubernetes Master Machine:

`../scripts/setup-kubernetes-node-agent.sh`:

```bash
#!/bin/bash

# Enable noninteractive mode to suppress any interactive user prompt
export DEBIAN_FRONTEND=noninteractive

kubeadm token create --print-join-command 2>/dev/null

```

### Explanations

The line below retrieves a command for Kubernetes Node Agents to join the Kubernetes Cluster. It needs to be executed on the Kubernetes Master Machine:

```bash
kubeadm token create --print-join-command 2>/dev/null
```

The returned command lets a Kubernetes Node Agent join to the Kubernetes Cluster. The command needs to be executed on a Kubernetes Node Agent Machine. The command looks like the line below:

```bash
kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

