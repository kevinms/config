#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

plugin=~/.vim/autoload/pathogen.vim
if [ ! -d $plugin ]; then
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso $plugin https://tpo.pe/pathogen.vim
fi

plugin=~/.vim/bundle/ctrlp.vim
if [ ! -d $plugin ]; then
	git clone https://github.com/kien/ctrlp.vim.git $plugin
fi

plugin=~/.vim/bundle/vim-sneak
if [ ! -d $plugin ]; then
	git clone git://github.com/justinmk/vim-sneak.git $plugin
fi

plugin=~/.vim/bundle/taby.vim
if [ ! -d $plugin ]; then
	git clone git://github.com/kevinms/taby.vim.git $plugin
fi

plugin=~/.vim/bundle/vim-eunuch
if [ ! -d $plugin ]; then
	git clone https://github.com/tpope/vim-eunuch.git $plugin
fi

plugin=~/.vim/bundle/goyo.vim
if [ ! -d $plugin ]; then
	git clone https://github.com/junegunn/goyo.vim.git $plugin
fi

plugin=~/.vim/bundle/limelight.vim
if [ ! -d $plugin ]; then
	git clone https://github.com/junegunn/limelight.vim.git $plugin
fi

must_not_exist() {
	if [ -f $1 ]; then
		echo "$1 already exists?!"
		exit 1
	fi
}

must_not_exist ~/.vimrc
must_not_exist ~/.tmux.conf

ln -s $(realpath $DIR/.vimrc) ~/.vimrc
ln -s $(realpath $DIR/.tmux.conf) ~/.tmux.conf

ls -lash ~/.vimrc ~/.tmux.conf

