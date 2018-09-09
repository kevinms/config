#!/bin/bash

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

# Install custom xfce4-terminal theme.
mkdir -p ~/.local/share/xfce4/terminal/colorschemes
cp $(realpath $DIR/xfce4-colorscheme.theme) \
	~/.local/share/xfce4/terminal/colorschemes

plugin=~/.vim/autoload/pathogen.vim
if [ ! -d $plugin ]; then
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso $plugin https://tpo.pe/pathogen.vim
fi

clone() {
	if [ ! -d $2 ]; then
		git clone $1 $2
	fi
}

clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
clone git://github.com/justinmk/vim-sneak.git ~/.vim/bundle/vim-sneak
clone git://github.com/kevinms/taby.vim.git ~/.vim/bundle/taby.vim
clone https://github.com/tpope/vim-eunuch.git ~/.vim/bundle/vim-eunuch
clone https://github.com/junegunn/goyo.vim.git ~/.vim/bundle/goyo.vim
clone https://github.com/junegunn/limelight.vim.git ~/.vim/bundle/limelight.vim
