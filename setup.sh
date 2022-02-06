#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
pushd "$DIR" > /dev/null

print_help() {
	echo "$0 [-f|--force] [-h|--help]"
	exit 1
}

while [[ "$#" > 0 ]]; do
	case $1 in
		-f|--force) force=1;;
		-h|--help) print_help;;
		*) echo "Unknown parameter passed: $1"; exit 1;;
	esac
	shift;
done

ask_to_continue() {
	while true; do
		read -p "$1 Enter y/n: " answer
		case $answer in
			[Yy] ) break;;
			[Nn] ) exit 1;;
			* ) echo "Please answer y or n.";;
		esac
	done
}

link_or_ask() {
	eval TARGET=$1
	eval LINK_NAME=$2
	if [[ ! -f "$LINK_NAME" ]]; then
		ln -s $(realpath "$TARGET") "$LINK_NAME"
	fi
	if [[ ! "$TARGET" -ef "$LINK_NAME" ]]; then
		echo "WARNING: $LINK_NAME already exists?!"
		ask_to_continue "Do you want to overwrite it?"
		rm -f "$LINK_NAME"
		ln -s $(realpath "$TARGET") "$LINK_NAME"
	fi
}

#
# Setup bash
#
if ! grep $(realpath .bashrc) ~/.bashrc; then
	echo "Adding custom bashrc to .bashrc"
	echo -e "\nsource $(realpath .bashrc)" >> ~/.bashrc
fi
source ~/.bashrc

#
# Setup tmux
#
link_or_ask .tmux.conf ~/.tmux.conf

#
# Setup vim
#
link_or_ask .vimrc ~/.vimrc

mkdir -p ~/.vim
link_or_ask coc-settings.json ~/.vim/coc-settings.json

#
# Setup terminal
#
pushd colorscheme > /dev/null
if which xfce4-terminal; then
	# gruvbox xfce4-terminal theme -- slightly customized
	mkdir -p ~/.local/share/xfce4/terminal/colorschemes
	cp xfce4-colorscheme.theme ~/.local/share/xfce4/terminal/colorschemes

	# gruvbox xfce4-terminal theme
	[[ ! -d gruvbox-contrib ]] && git clone https://github.com/morhetz/gruvbox-contrib.git
	mkdir -p ~/.local/share/xfce4/terminal/colorschemes
	cp gruvbox-contrib/xfce4-terminal/*.theme ~/.local/share/xfce4/terminal/colorschemes/
fi
if which tilix; then
	# gruvbox tilix theme
	[[ ! -d tilix-gruvbox ]] && git clone git@github.com:MichaelThessel/tilix-gruvbox.git
	mkdir -p ~/.config/tilix/schemes
	cp tilix-gruvbox/gruvbox-* ~/.config/tilix/schemes/
fi
popd > /dev/null

#
# Warn about vim plugin dependencies
#
if ! which go; then
	echo "WARNING: vim plugins need 'go' installed and in your PATH"
fi
if ! which node; then
	echo "WARNING: vim plugins need 'node' installed and in your PATH"
fi
