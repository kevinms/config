#!/bin/bash

set -euo pipefail

# Must run as root
if ! [ "${EUID:-$(id -u)}" -eq 0 ]; then
	echo "ERROR: root privileges are needed to run this script"
	exit 1
fi

set -x

apt update -y
apt upgrade -y
apt install -y \
	vim git tmux \
	build-essential clangd \
	zip unzip wget curl jq tree \
	smartmontools sysstat

# Docker
if ! which docker; then
	curl -fsSL https://get.docker.com -o get-docker.sh
	sh get-docker.sh
	rm -f get-docker.sh
	usermod -aG docker kevin
fi

# Go
if ! which go; then
	version=$(curl https://go.dev/VERSION?m=text | head -1)
	wget https://go.dev/dl/$version.linux-amd64.tar.gz
	rm -rf /usr/local/go && tar -C /usr/local -xzf $version.linux-amd64.tar.gz
	rm -f $version.linux-amd64.tar.gz
fi

YELLOW='\e[1;33m'
RESET='\e[0m'
printf "\n${YELLOW}Completed server install.${RESET}\n"

sudo -i -u kevin $PWD/install-server-user.sh
