#!/bin/bash

## install kubectl

VERSION="3.14.1"

BASE_URL="https://dl.k8s.io/release"

case `uname -m` in 
    x86_64) ARCH=amd64; ;; 
    armv7l) ARCH=arm; ;; 
    aarch64) ARCH=arm64; ;; 
    ppc64le) ARCH=ppc64le; ;; 
    s390x) ARCH=s390x; ;; 
    *) echo "un-supported arch, exit ..."; exit 1; ;; 
esac 
curl -LO "${BASE_URL}/$(curl -L -s ${BASE_URL}/stable.txt)/bin/linux/${ARCH}/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc