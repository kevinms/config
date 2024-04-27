#!/bin/bash -i

set -euo pipefail

set -x

mkdir -p ~/{bin,dev}

# NodeJS
if ! which node; then
	curl https://get.volta.sh | bash
	export VOLTA_HOME="$HOME/.volta"
	export PATH="$VOLTA_HOME/bin:$PATH"
	volta install node
fi

# Godot
downloadLink=$(curl -s https://api.github.com/repos/godotengine/godot/releases/latest \
	| jq -r '.assets[] | select(.browser_download_url | contains("linux.x86_64")).browser_download_url')
archiveName=${downloadLink##*/}
binaryName="${archiveName%.*}"
if ! which $binaryName; then
	wget $downloadLink
	unzip $archiveName -d ~/bin/
	rm $archiveName
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
