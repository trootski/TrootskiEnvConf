" tell vim where to find the runtime folder
set runtimepath^=~/TrootskiEnvConf/.vim

" Remap jj to be the escape keys
ino jj <esc>
cno jj <c-c>

nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

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
set clipboard=unnamed
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

" Stop the exit to CLI when hitting up accidentally
vnoremap K k

" -------------------------------------------------------------------------------
"  NERD TREE STUFF
" -------------------------------------------------------------------------------
let NERDTreeIgnore=['\.pyc$', '\~$']
map <F2> :NERDTreeToggle<CR>

au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
autocmd BufRead *.as set filetype=actionscript

" -------------------------------------------------------------------------------
"  BUFFER RE-MAPPINGS
" -------------------------------------------------------------------------------
" Move to the previous buffer with "gp"
nnoremap gp :bp<CR>

" Move to the next buffer with "gn"
nnoremap gn :bn<CR>

" List all possible buffers with "gl"
nnoremap gl :ls<CR>

" List all possible buffers with "gb" and accept a new buffer argument [1]
nnoremap gb :ls<CR>:b
" Delete the current buffer but don't close the window
nnoremap gd :bp\|bd #<CR>

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
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'r'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
if exists("g:ctrl_user_command")
	unlet g:ctrlp_user_command
endif
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
\ }
set wildignore+=*/vendor/*
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*
set wildignore+=*/components/*

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" -------------------------------------------------------------------------------

" -------------------------------------------------------------------------------
"  SYNTASTIC
" -------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_quiet_messages = { "type": "syntax" }
let g:syntastic_php_checkers = ['php']
" -------------------------------------------------------------------------------

" -------------------------------------------------------------------------------
"  AIRLINE
" -------------------------------------------------------------------------------
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" -------------------------------------------------------------------------------
"  TAGBAR
" -------------------------------------------------------------------------------
" autocmd FileType php,blade,javascript nested :TagbarOpen

" Disable the mouse on Linux
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
	set mouse=
endif
