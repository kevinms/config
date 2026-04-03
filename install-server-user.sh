#!/bin/bash -i

set -euo pipefail

set -x

mkdir -p ~/{bin,dev}

if ! which go; then
	echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
	echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
fi

# NodeJS
if ! which node; then
	curl https://get.volta.sh | bash
	export VOLTA_HOME="$HOME/.volta"
	export PATH="$VOLTA_HOME/bin:$PATH"
	volta install node
fi

YELLOW='\e[1;33m'
RESET='\e[0m'
printf "\n${YELLOW}Completed server install for user.${RESET}\n"
