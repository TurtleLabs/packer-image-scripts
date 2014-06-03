#!/bin/bash -eux

sudo apt-get update
sudo apt-get -y upgrade

# Install necessary libraries for guest additions and Vagrant NFS Share
sudo apt-get -y install linux-headers-$(uname -r) build-essential dkms nfs-common git-core whois traceroute htop unzip sysstat linux-headers-generic vim libmysqlclient-dev postgresql-server-dev-9.3

sudo apt-get clean