"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

execute pathogen#infect()

" Plugins -> ctrlp.vim, vim-sneak, taby.vim

" Enable filetype plugins.
filetype plugin on
filetype indent on

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Leader key
"nnoremap <SPACE> <Nop>
"let mapleader=' '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enhanced tab completion for commands.
set wildmenu

"Always show current position.
set ruler

" Display incomplete commands.
set showcmd

" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" Show line numbers.
"set nonumber
set relativenumber

" Toggle paste mode on and off.
map <leader>p :setlocal paste!<cr>

" lightline.vim config
"let g:lightline = {'colorscheme': 'wombat'}

" Move cursor by dipslay lines when wrapping
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
syntax on

colorscheme elflord
set t_Co=8
"set t_Co=256

set background=dark

highlight LineNr term=bold cterm=NONE ctermfg=DarkGray ctermbg=NONE
highlight CursorLineNr term=bold cterm=NONE ctermfg=Red ctermbg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set formatoptions+=cro

set smarttab
set smartindent
set autoindent

" Always insert tabs.
command IndentTabs set ts=4 sw=4 noet

" Always insert spaces.
command IndentSpaces set ts=4 sw=4 et

" Use a mix of tabs and spaces, but typing <Tab> and <BS> will
" behave like a tab appears every 4 (or 3) characters.
command IndentMix set ts=8 sts=4 sw=4 noet

IndentTabs
autocmd Filetype * setlocal ts=4 sw=4 noet

autocmd BufNewFile,BufRead ~/transporter/* set ts=4 sw=4 noet
autocmd BufNewFile,BufRead ~/cpu/* set ts=4 sw=4 noet
autocmd BufNewFile,BufRead ~/doc/code/profiler/* set ts=4 sw=4 noet

" Reformat selection -- justifies text. Just press: gq
" More useful when autoindent is set and nojoinspaces.
"set textwidth=80
"set nojoinspaces

" show whitespace
set listchars=tab:>-,trail:~,extends:>,precedes:<
set nolist

" Keep selection when identing
vnoremap > >gv
vnoremap <lt> <lt>gv

" Toggle and untoggle spell checking.
map <leader>s :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Mapping to edit vimrc
nmap <Leader>v :edit $MYVIMRC<CR>

" Open a Quickfix window for the last search.
nnoremap <silent> <Leader>q :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Mapping to switch between .c and .h files
map <F5> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

set showtabline=2
nnoremap <C-PageUp> gT
nnoremap <C-PageDown> gt

" Folding Settings
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1
set foldlevel=0
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => cscope Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("cscope")
	set cscopetag cscopeverbose

	if has("quickfix")
		set cscopequickfix=s-,c-,d-,i-,t-,e-
	endif

	cnoreabbrev <expr> csa
			\ ((getcmdtype() == ":" && getcmdpos() <= 4)? "cs add"  : "csa")
	cnoreabbrev <expr> csf
			\ ((getcmdtype() == ":" && getcmdpos() <= 4)? "cs find" : "csf")
	cnoreabbrev <expr> csk
			\ ((getcmdtype() == ":" && getcmdpos() <= 4)? "cs kill" : "csk")
	cnoreabbrev <expr> csr
			\ ((getcmdtype() == ":" && getcmdpos() <= 4)? "cs reset" : "csr")
	cnoreabbrev <expr> css
			\ ((getcmdtype() == ":" && getcmdpos() <= 4)? "cs show" : "css")
	cnoreabbrev <expr> csh
			\ ((getcmdtype() == ":" && getcmdpos() <= 4)? "cs help" : "csh")

	"command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src

	" Automatically load CScope
	function! LoadCscope()
		let db = findfile("cscope.out", ".;")
		if (!empty(db))
			let path = strpart(db, 0, match(db, "/cscope.out$"))
			set nocscopeverbose " suppress 'duplicate connection' error
			exe "cs add " . db . " " . path
			set cscopeverbose
		endif
	endfunction
	au BufEnter /* call LoadCscope()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Writing Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable Goyo/Limelight
map <leader>g :Goyo<cr>
map <leader>l :Limelight!!<cr>

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  let g:limelight_conceal_ctermfg = 240
  set t_Co=256
  Limelight
  set wrap linebreak nolist
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  set t_Co=8
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Write file with super user permissions
"command! SudoWrite w !sudo tee > /dev/null %

" Have Vim jump to the last position when reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Mapping to edit vimrc
nmap <Leader>r :CtrlPClearAllCaches<CR>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

function! SetupPython()
    " Here, you can have the final say on what is set.  So
    " fixup any settings you don't like.
	IndentTabs
endfunction
command! -bar SetupPython call SetupPython()
