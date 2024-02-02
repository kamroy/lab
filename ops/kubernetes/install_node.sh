#!/bin/bash

## install nodes for k8s

TOKEN="abcdef.0123456789abcdef"
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $2}')
echo "START - install node - "$IP

echo "[0]: reset cluster if exist"
kubeadm reset -f

echo "fix containerd issue"
rm /etc/containerd/config.toml
systemctl restart containerd

echo "[1]: kubadm join"
sysctl net.bridge.bridge-nf-call-iptables=1
kubeadm join --token="$TOKEN" 192.168.100.10:6443 --discovery-token-unsafe-skip-ca-verification

echo "[2]: restart and enable kubelet"
systemctl enable kubelet
service kubelet restart

echo "END - install node - " $IP
