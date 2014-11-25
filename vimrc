
" tell vim where to find the runtime folder
set runtimepath^=~/TrootskiEnvConf/.vim/

call pathogen#infect()
call pathogen#helptags()
set nocompatible

" Color Scheme stuff
"let g:jellybeans_use_lowcolor_black = 0
syntax enable
set background=dark
set bg=dark
colorscheme jellybeans

set autoindent
set backspace=indent,eol,start
set bs=2		" allow backspacing over everything
set clipboard=unnamedplus
if version >= 703
	set colorcolumn=85
endif
set cursorline
set encoding=utf-8
set formatoptions=qrn1
set hidden
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set modeline	" enable modelines to be read
set mouse=a		" allow mouse support in console
set nocompatible
" backup to ~/.tmp 
set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup
set nobackup
set nowritebackup

set nu			" line numbering
if version >= 703
	set relativenumber
endif
set ruler
set ruler		" show current coords of cursor
set scrolloff=3
set showcmd
set showmode
set textwidth=79
set ttyfast
set ttymouse=xterm2		" allows mouse to work in screen sessions
set visualbell
set wildmenu
set wildmode=list:longest
set wrap

"
" Undo
"
set undolevels=1000
if version >= 730
	set undofile
	set undodir=$HOME/.vim/undo
	set undoreload=1000
endif


"
" Searching
"
set ignorecase	" case insensitive searching
set incsearch	" search as you type


"
" Tabbing
"
set autoindent      " auto indent on new line
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab       " use tabs by default

set formatoptions=ro " Enable automatic comment leaders

" set the title of the terminal to the name of the file you are editing
set title
set titleold=""

" command line completion
set wildmode=list:longest,full


" Edit/save another file in the same directory as the current file
" uses expression to extract path from current file's path
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,sp :sp <C-R>=expand("%:p:h") . "/" <CR>
map ,vsp :vsp <C-R>=expand("%:p:h") . "/" <CR>
map ,w :w <C-R>=expand("%:p:h") . "/" <CR>
map ,sav :sav <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>

" NERD_tree should ignore .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$']
map <F2> :NERDTreeToggle<CR>

au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
autocmd BufRead *.as set filetype=actionscript

" -------------------------------------------------------------------------------
"  TAB MAPPINGS
" -------------------------------------------------------------------------------
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>
" -------------------------------------------------------------------------------

" -------------------------------------------------------------------------------
"  CTRL-P
" -------------------------------------------------------------------------------
set runtimepath^=~/TrootskiEnvConf/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" -------------------------------------------------------------------------------

" Disable the mouse on Linux
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
	set mouse=
endif
