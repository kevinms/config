#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

ln -s $(realpath $DIR/.vimrc) ~/.vimrc
ln -s $(realpath $DIR/.tmux.conf) ~/.tmux.conf

if [ ! -d "~/.vim/autoload/pathogen.vim" ]; then
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

if [ ! -d "~/.vim/bundle/ctrlp.vim" ]; then
	git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
fi

if [ ! -d "~/.vim/bundle/vim-sneak" ]; then
	git clone git://github.com/justinmk/vim-sneak.git ~/.vim/bundle/vim-sneak
fi

if [ ! -d "~/.vim/bundle/taby.vim" ]; then
	git clone git://github.com/kevinms/taby.vim.git ~/.vim/bundle/taby.vim
fi

if [ ! -d "~/.vim/bundle/vim-eunuch" ]; then
	git clone https://github.com/tpope/vim-eunuch.git ~/.vim/bundle/vim-eunuch
fi

