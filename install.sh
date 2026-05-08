#!/bin/bash

set -euo pipefail

PROG=$0

help()
{
	echo "$PROG [-h|--help] [-s|--server] [-d|--desktop]"
	exit $1
}

while [[ $# > 0 ]]; do
	case $1 in
		-h|--help) help 0;;
		-s|--server) DO_SERVER=1; shift;;
		-d|--desktop) DO_DESKTOP=1; shift;;
		-*|--*) echo "Unknown option: $1"; help 1;;
		*) break;;
	esac
done

# Must run as root
if ! [ "${EUID:-$(id -u)}" -eq 0 ]; then
	echo "ERROR: root privileges are needed to run this script"
	exit 1
fi

function install_minimal() {
	packages=(
		# Essential
		vim git tmux

		# Basic utilities
		zip unzip wget curl jq yq tree ncdu

		# Debug
		iotop btop htop

		# Disk utilities
		smartmontools sysstat
	)

	apt install -y "${packages[@]}"

	if ! which docker; then
		curl -fsSL https://get.docker.com -o get-docker.sh
		sh get-docker.sh
		rm -f get-docker.sh
		#usermod -aG docker kevin
	fi

	export PATH=$PATH:/usr/local/go/bin
	if ! which go; then
		version=$(curl -s https://go.dev/VERSION?m=text | head -1)
		wget https://go.dev/dl/$version.linux-amd64.tar.gz
		rm -rf /usr/local/go && tar -C /usr/local -xzf $version.linux-amd64.tar.gz
		rm -f $version.linux-amd64.tar.gz
	fi
}


function install_server() {
	packages=(
		openssh-server
	)

	apt install -y "${packages[@]}"
}

function install_desktop() {
	packages=(
		# Essential
		tilix gedit

		# Build tools
		build-essential clangd

		# Virtualization
		virtualbox qemu-system qemu-kvm virt-manager

		# Remote management
		openssh-server ansible remmina

		# Graphics and audio
		gimp inkscape krita audacity kcolorchooser

		# LaTex editor
		gummi

		# Screen capture and recording
		peek
	)

	apt install -y "${packages[@]}"

	if ! which nordvpn; then
		sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
	fi

	if ! which obs; then
		add-apt-repository -y ppa:obsproject/obs-studio
		apt install -y ffmpeg v4l2loopback-dkms obs-studio
	fi

	# if ! which lutris; then
	# 	add-apt-repository -y ppa:lutris-team/lutris
	# 	apt install -y lutris winetricks
	# fi

	if ! which steam; then
		add-apt-repository -y multiverse
		apt install -y steam
	fi

	if ! which discord; then
		wget -O /tmp/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
		apt install -y /tmp/discord.deb
		rm -f /tmp/discord.deb
	fi

	if ! which keepassxc; then
		add-apt-repository -y ppa:phoerious/keepassxc
		apt install -y keepassxc
	fi

	#TODO: ibus / anthy
	# apt install -y ibus ibus-anthy
	# apt install -y ibus-gtk ibus-gtk3 # Is this needed?

	if ! which google-chrome; then
		wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		dpkg -i /tmp/google-chrome.deb
		rm -f /tmp/google-chrome.deb
	fi

	if ! which brave-browser; then
		curl -fsS https://dl.brave.com/install.sh | sh
	fi
	
	if ! which opencode; then
		curl -fsSL https://opencode.ai/install | bash
	fi

	snap install codium --classic
	snap install blender --classic
}


set -x

apt update -y
apt upgrade -y

install_minimal

if [ ! -z "${DO_SERVER+x}" ]; then
	install_server
fi
if [ ! -z "${DO_DESKTOP+x}" ]; then
	install_desktop
fi

# Run install commands that must be done as non-root user:
scriptDir=$(realpath $(dirname "$0"))
sudo -u kevin $scriptDir/install-user.sh
# sudo -i -u kevin $PWD/install-server-user.sh

cat <<EoF
Manually install the following programs:
	darktable
EoF
