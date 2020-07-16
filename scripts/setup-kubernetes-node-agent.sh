#!/bin/bash

# Enable noninteractive mode to suppress any interactive user prompt
export DEBIAN_FRONTEND=noninteractive

kubeadm token create --print-join-command 2>/dev/null
