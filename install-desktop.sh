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

packages=(
	# Essential
	vim git tmux tilix

	# Basic utilities
	zip unzip wget curl jq yq tree ncdu gedit

	# Build tools
	build-essential clangd

	# Virtualization
	# virtualbox qemu-system qemu-kvm virt-manager

	# Remote management
	# openssh-server ansible remmina
	remmina

	# Disk utilities
	smartmontools sysstat

	# Graphics and audio
	gimp inkscape krita audacity kcolorchooser

	# LaTex editor
	gummi

	# Screen capture and recording
	peek
)

apt install -y "${packages[@]}"

# VPN
if ! which nordvpn; then
	sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
fi

# Screen capture and recording
#if ! which obs; then
#	apt install -y ffmpeg
#	apt install -y v4l2loopback-dkms
#	add-apt-repository -y ppa:obsproject/obs-studio
#	apt install -y obs-studio
#fi

# Gaming
#if ! which lutris; then
#	add-apt-repository -y ppa:lutris-team/lutris
#	apt install -y lutris
#	apt install -y winetricks
#fi
if ! which steam; then
	add-apt-repository -y multiverse
	apt install -y steam
fi

# Messaging
#apt install -y pidgin pidgin-otr
if ! which discord; then
	wget -O /tmp/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	apt install -y /tmp/discord.deb
	rm -f /tmp/discord.deb
fi

if ! which keepassxc; then
	add-apt-repository -y ppa:phoerious/keepassxc
	apt install -y keepassxc
fi

if ! which docker; then
	curl -fsSL https://get.docker.com -o get-docker.sh
	sh get-docker.sh
	rm -f get-docker.sh
	#usermod -aG docker kevin
fi

# Go
export PATH=$PATH:/usr/local/go/bin
if ! which go; then
	version=$(curl https://go.dev/VERSION?m=text | head -1)
	wget https://go.dev/dl/$version.linux-amd64.tar.gz
	rm -rf /usr/local/go && tar -C /usr/local -xzf $version.linux-amd64.tar.gz
	rm -f $version.linux-amd64.tar.gz
	# The PATH should already or will be set correctly in .profile or .bashrc
	#export PATH=$PATH:/usr/local/go/bin
	#export PATH=$PATH:~/go/bin
fi

# GUI Code Editor
snap install codium --classic

# Game Dev
#snap install blender --classic

#TODO: ibus / anthy
# apt install -y ibus ibus-anthy
# apt install -y ibus-gtk ibus-gtk3 # Is this needed?

# Browsers
if ! which google-chrome; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	dpkg -i google-chrome-stable_current_amd64.deb
	rm -f google-chrome-stable_current_amd64.deb
fi
if ! which brave-browser; then
	curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
		https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
		| sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	apt update -y
	apt install -y brave-browser
fi

# Run install commands that must be done as non-root user:
scriptDir=$(realpath $(dirname "$0"))
sudo -u kevin $scriptDir/install-desktop-user.sh

cat <<EoF
Manually install the following programs:
	darktable
EoF
