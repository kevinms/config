#!/bin/bash -i

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

# Must not be root
if [ "${EUID:-$(id -u)}" -eq 0 ]; then
	echo "ERROR: cannot be root while running this script"
	exit 1
fi

function install_common() {
	if ! which node; then
		curl https://get.volta.sh | bash
		export VOLTA_HOME="$HOME/.volta"
		export PATH="$VOLTA_HOME/bin:$PATH"
		volta install node
	fi
}

function install_server() {
	if ! which go; then
		echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
		echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
	fi
}

function install_desktop() {
	if ! which godot; then
		downloadLink=$(curl -s https://api.github.com/repos/godotengine/godot/releases/latest \
			| jq -r '.assets[] | select(.browser_download_url | contains("linux.x86_64")).browser_download_url')
		archiveName=${downloadLink##*/}
		binaryName="${archiveName%.*}"
		wget -O /tmp/godot.zip $downloadLink
		unzip /tmp/godot.zip -d ~/bin/
		rm /tmp/godot.zip
		ln -sf ~/bin/$binaryName ~/bin/godot
	fi

	# Configure VSCode marketplace
	if which codium; then
		mkdir -p ~/.config/VSCodium/
		cat <<-"EoF" > ~/.config/VSCodium/product.json
			{
			  "extensionsGallery": {
				"serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
				"itemUrl": "https://marketplace.visualstudio.com/items",
				"cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
				"controlUrl": ""
			  }
			}
		EoF
	fi
}

set -x

mkdir -p ~/{bin,dev}

install_common

if [ ! -z "${DO_SERVER+x}" ]; then
	install_server
fi
if [ ! -z "${DO_DESKTOP+x}" ]; then
	install_desktop
fi

YELLOW='\e[1;33m'
RESET='\e[0m'
printf "\n${YELLOW}Completed install for user.${RESET}\n"
