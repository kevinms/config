#!/bin/bash

set -euo pipefail

#TODO: Must run as root
if ! [ "${EUID:-$(id -u)}" -eq 0 ]; then
	echo "ERROR: root privileges are needed to run this script"
	exit 1
fi

set -x

apt update -y
apt upgrade -y

# Critical
apt install -y vim git tmux

# Build tools
apt install -y build-essential clangd

# Basic utilities
apt install -y zip unzip wget curl jq

# Disk utilities
apt install -y smartmontools sysstat

# Docker
if ! which docker; then
	curl -fsSL https://get.docker.com -o get-docker.sh
	sh get-docker.sh
	rm -f get-docker.sh
	usermod -aG docker kevin
fi
apt install -y docker-compose

# Go
export PATH=$PATH:/usr/local/go/bin
if ! which go; then
	version=$(curl https://go.dev/VERSION?m=text)
	wget https://go.dev/dl/$version.linux-amd64.tar.gz
	rm -rf /usr/local/go && tar -C /usr/local -xzf $version.linux-amd64.tar.gz
	rm -f $version.linux-amd64.tar.gz
	# The PATH should already or will be set correctly in .profile or .bashrc
	#export PATH=$PATH:/usr/local/go/bin
	#export PATH=$PATH:~/go/bin
fi

# NodeJS
if ! which node; then
	curl -sL install-node.now.sh/lts > nodejs-lts.sh
	bash nodejs-lts.sh -y
	rm -f nodejs-lts.sh
fi

