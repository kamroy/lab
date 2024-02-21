#!/bin/bash

## install helm

VERSION="3.14.1"

BASE_URL="https://get.helm.sh"

case `uname -m` in 
    x86_64) ARCH=amd64; ;; 
    armv7l) ARCH=arm; ;; 
    aarch64) ARCH=arm64; ;; 
    ppc64le) ARCH=ppc64le; ;; 
    s390x) ARCH=s390x; ;; 
    *) echo "un-supported arch, exit ..."; exit 1; ;; 
esac 
wget ${BASE_URL}/helm-v${VERSION}-linux-${ARCH}.tar.gz -O - | tar -xz
mv linux-${ARCH}/helm /usr/local/bin/helm
chmod +x /usr/local/bin/helm
rm -rf linux-${ARCH}

helm completion bash > /etc/bash_completion.d/helm