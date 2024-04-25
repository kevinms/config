"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Updating plugins:
" 
" :PlugUpdate
" :CocUpdate
" :GoUpdateBinaries

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'       " Fuzzy finder
Plug 'jiangmiao/auto-pairs'     " Insert or delete brackets, parens, quotes in pairs
Plug 'justinmk/vim-sneak'       " Jump to any location specified by two characters
Plug 'kevinms/taby.vim'         " Custom tab line
Plug 'tpope/vim-eunuch'         " :SudoWrite and :SudoEdit
Plug 'tpope/vim-sleuth'         " Heuristically set indention
Plug 'tpope/vim-surround'       " Delete/change/add parentheses/quotes/XML-tags/much more with ease
Plug 'farmergreg/vim-lastplace' " Intelligently reopen files at your last edit position
Plug 'junegunn/vim-slash'       " Improve search highlighting
Plug 'junegunn/goyo.vim'        " Distraction-free writing
Plug 'junegunn/limelight.vim'   " Hyperfocus-writing
Plug 'tomtom/tcomment_vim'      " Easily add/remove comments
Plug 'morhetz/gruvbox'          " The best colorscheme

" Language plugins:
Plug 'arrufat/vala.vim'
Plug 'hashivim/vim-terraform'
Plug 'chr4/nginx.vim'
Plug 'posva/vim-vue'
Plug 'cespare/vim-toml'
Plug 'tikhomirov/vim-glsl'
Plug 'habamax/vim-godot'

" Requires:
"   go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Requires:
"   nodejs >= 11.12
"   	curl -sL install-node.now.sh/lts | sudo bash
"   vim >= 8.0.1453
"   	sudo add-apt-repository ppa:jonathonf/vim
"   	sudo apt update
"   	sudo apt install vim
"
" Install:
"   clangd
"   	:CocCommand clangd.install
"   coc-settings.json
"   	Place coc-settings.json in ~/.vim/
"
let g:coc_global_extensions = [
    \'coc-tsserver', 'coc-html', 'coc-css',
    \'coc-swagger',
    \'coc-markdownlint',
    \'coc-json', 'coc-yaml',
    \'coc-godot',
    \'coc-rust-analyzer',
\]
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
    " \'coc-python',
    " \'coc-clangd',

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype plugins.
filetype plugin on
filetype indent on

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Leader key
"nnoremap <SPACE> <Nop>
"let mapleader=' '

inoremap jk <ESC>

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
"set number
set relativenumber
nnoremap <leader>a :set number! \| :set relativenumber!<cr>

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

" set t_Co=256

" Theme: elflord
" set t_Co=8
" colorscheme elflord

" Theme: gruvbox
set termguicolors
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

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
command IndentSpaces set ts=2 sw=2 et

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
nmap <Leader>v :tabedit $MYVIMRC<CR>

" Open a Quickfix window for the last search.
nnoremap <silent> <Leader>q :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Mapping to switch between .c and .h files
map <F5> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

" Close the quickfix window
" nmap <Leader>r :cclose<CR>

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
" => Go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

augroup LspGo
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'go-lang',
      \ 'cmd': {server_info->['gopls']},
      \ 'whitelist': ['go'],
      \ })
  autocmd FileType go setlocal omnifunc=lsp#complete
  "autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
  "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
  "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
augroup END

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')


" Mapping to edit vimrc
nmap <Leader>b :GoBuild<CR>
nmap <Leader>i :GoImports<CR>
nmap <Leader>t :GoTest<CR>
nmap <Leader>f :GoTestFunc<CR>
nmap <Leader>c :GoCoverageToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => auto-pairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:AutoPairsCenterLine = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-terraform
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:terraform_fmt_on_save=1

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Conquer of Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set hidden
"
" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
" set updatetime=300
"
" " Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
"
" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif
"
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" " inoremap <silent><expr> <TAB>
" "       \ pumvisible() ? "\<C-n>" :
" "       \ <SID>check_back_space() ? "\<TAB>" :
" "       \ coc#refresh()
" " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
"
" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
"
" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
"
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
"
"


" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=number

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

