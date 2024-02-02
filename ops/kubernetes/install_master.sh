#!/bin/bash

## install master for k8s

TOKEN="abcdef.0123456789abcdef"
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $2}')
echo "START - install master - "$IP

echo "[0]: reset cluster if exist"
kubeadm reset -f

echo "fix containerd issue"
rm /etc/containerd/config.toml
systemctl restart containerd

echo "[1]: kubadm init"
kubeadm init --apiserver-advertise-address=$IP --token="$TOKEN" --pod-network-cidr=10.244.0.0/16

echo "[2]: create config file"
mkdir $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "[3]: create flannel pods network"
sysctl net.bridge.bridge-nf-call-iptables=1
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

echo "[4]: restart and enable kubelet"
systemctl enable kubelet
service kubelet restart

echo "END - install master - " $IP
