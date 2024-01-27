#!/bin/bash
yum -y update
yum -y install epel-release

# install ansible
yum -y install ansible

#retrieve ansible code
yum -y install git

