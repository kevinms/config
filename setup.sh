#!/bin/bash

set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

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

mkdir ~/.vim
ln -s $(realpath $DIR/coc-settings.json) ~/.vim/

must_not_exist() {
	if [ -f $1 ]; then
		if (($force)); then
			rm -f $1
			return
		fi
		echo "$1 already exists?!"
		exit 1
	fi
}

must_not_exist ~/.vimrc
must_not_exist ~/.tmux.conf

ln -s $(realpath $DIR/.vimrc) ~/.vimrc
ln -s $(realpath $DIR/.tmux.conf) ~/.tmux.conf

ls -lash ~/.vimrc ~/.tmux.conf

if which xfce4-terminal; then
	# Install custom xfce4-terminal theme.
	mkdir -p ~/.local/share/xfce4/terminal/colorschemes
	cp $(realpath $DIR/xfce4-colorscheme.theme) \
		~/.local/share/xfce4/terminal/colorschemes

	# gruvbox xfce4-terminal theme
	git clone https://github.com/morhetz/gruvbox-contrib.git
	mkdir -p ~/.local/share/xfce4/terminal/colorschemes
	cp gruvbox-contrib/xfce4-terminal/*.theme ~/.local/share/xfce4/terminal/colorschemes/
fi

if which tilix; then
	git clone git@github.com:MichaelThessel/tilix-gruvbox.git
	mkdir -p ~/.config/tilix/schemes
	cp tilix-gruvbox/gruvbox-* ~/.config/tilix/schemes/
fi

