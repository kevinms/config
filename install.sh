#!/bin/bash

set -euxo pipefail

#TODO: Must run as root

apt update
apt upgrade

# Critical
apt install vim git tmux tilix

# Build tools
apt install build-essential clangd

# Basic utilities
apt install zip unzip gedit gparted

# Virtualization
apt install remmina virtualbox qemu qemu-kvm virt-manager

# SSH server
apt install openssh-server

# VPN plugins
apt install network-manager-openconnect network-manager-l2tp

# Disk utilities
apt install smartmontools sysstat

# Graphics and audio
apt install gimp inkscape krita audacity

# Backups
apt install timeshift

# LaTex editor
apt install gummi

# Screen capture and recording
apt install peek
if !which obs; then
	apt install ffmpeg
	apt install v4l2loopback-dkms
	add-apt-repository ppa:obsproject/obs-studio
	apt update
	apt install obs-studio
fi

# Gaming
apt install lutris winetricks
if !which steam; then
	add-apt-repository multiverse
	apt update
	apt install steam
fi

# Messaging
apt install pidgin pidgin-otr
if !which discord; then
	wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	dpkg -i discord.deb
	rm discord.deb
fi

#TODO: vscode

# keepassxc
if !which keepassxc; then
	add-apt-repository ppa:phoerious/keepassxc
	apt update
	apt install keepassxc
fi

# Docker
if !which docker; then
	curl -fsSL https://get.docker.com -o get-docker.sh
	sh get-docker.sh
	usermod -aG docker kevin
fi

# Go
if !which go; then
	version=$(curl https://go.dev/VERSION?m=text)
	wget https://go.dev/dl/$version.linux-amd64.tar.gz
	rm -rf /usr/local/go && tar -C /usr/local -xzf $version.linux-amd64.tar.gz
	rm $version.linux-amd64.tar.gz
	# The PATH should already or will be set correctly in .profile or .bashrc
	#export PATH=$PATH:/usr/local/go/bin
	#export PATH=$PATH:~/go/bin
fi

# NodeJS
if !which node; then
	curl -sL install-node.now.sh/lts | bash
fi

#TODO: ibus / anthy

# Browsers
if !which google-chrome; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb
fi
if !which brave-browser; then
	apt install apt-transport-https curl
	curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	apt update
	apt install brave-browser
fi

# Chat

cat <<EoF
Manually install the following programs:
	teams
	blender
	godot
EoF
