set shell=/bin/bash
"set runtimepath^=/home/troot/TrootskiEnvConf/.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/TrootskiEnvConf/.vim/bundle/Vundle.vim
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ---------------------------------------------------------------------------
"  INTERFACE STUFF
" ---------------------------------------------------------------------------
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'powerline/powerline'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" ---------------------------------------------------------------------------
"  THEMES
" ---------------------------------------------------------------------------
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'

" ---------------------------------------------------------------------------
"  UTILITIES
" ---------------------------------------------------------------------------
Plugin 'mattn/emmet-vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'marcweber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-dispatch'

" ---------------------------------------------------------------------------
"  SYNTAX/LANGUAGE SUPPORT
" ---------------------------------------------------------------------------
Plugin 'hail2u/vim-css3-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'sophacles/vim-processing'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'markcornick/vim-vagrant'
Plugin 'burnettk/vim-angular'
Plugin 'claco/jasmine.vim'
Plugin 'tpope/vim-dispatch'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Remap jj to be the escape keys
ino jj <esc>
cno jj <c-c>

nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>

" Color Scheme stuff
"let g:jellybeans_use_lowcolor_black = 0
syntax enable
set background=dark
set bg=dark
colorscheme jellybeans

set clipboard=unnamed
set nopaste
set go+=a

set autoindent
set backspace=indent,eol,start
set bs=2		" allow backspacing over everything
if version >= 703
	set colorcolumn=80
endif
set cursorline
set linebreak " Break lines on words, not characters
"set encoding=utf-8
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
set showbreak=↪

set nu			" line numbering
if version >= 703
	set relativenumber
endif
set ruler
set ruler		" show current coords of cursor
set scrolloff=3
set showcmd

" Always display the tabline, even if there is only one tab
set showtabline=2

" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

" Always display the statusline in all windows
set laststatus=2

set textwidth=79
set visualbell
set wildmenu
set wildmode=list:longest
set wrap
let mapleader=","

" Only have to type a semi-colon to get into command mode
noremap ; :

" Keep seection selected while indenting
vmap < <gv
vmap > >gv

"
" Undo
"
set undolevels=1000
if version >= 730
	set undofile
	set undodir=$HOME/.vim/undo//
	set undoreload=1000
endif

"
" Simple Copy/Paste
"
function! CopyRange() range
	:'<,'>w! /tmp/tmp.txt<cr>
endfunction

function! PasteRange()
	:r /tmp/tmp.txt<cr>
endfunction

vmap <F9> :call CopyRange()<cr>
nmap <F9> :call PasteRange()<cr>

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

" Spell check git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" Execute command on this line and replace with results of command
noremap Q !!sh<CR>

" ---------------------------------------------------------------------------
"  NERD TREE STUFF
" ---------------------------------------------------------------------------
let NERDTreeIgnore=['\.pyc$', '\~$']
map <F2> :NERDTreeToggle<CR>

" Resize splits when the window is resized
au VimResized * :wincmd =

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
autocmd BufRead *.as set filetype=actionscript

" ---------------------------------------------------------------------------
"  BUFFER RE-MAPPINGS
" ---------------------------------------------------------------------------
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

" In vimdiff ignore whitespace difference
set diffopt+=iwhite

" ---------------------------------------------------------------------------
"  TAB MAPPINGS
" ---------------------------------------------------------------------------
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
" ---------------------------------------------------------------------------

" ---------------------------------------------------------------------------
"  CTRL-P
" ---------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

if exists("g:ctrl_user_command")
	unlet g:ctrlp_user_command
endif

set wildignore+=*/bower_components/*,
set wildignore+=*/node_modules/*,
set wildignore+=*/vendor/*,

let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn|node_modules|bower_components|vendor|components)$',
	\ 'file': '\v\.(exe|so|dll|so|swp|zip|jpg|jpeg|png|gif)$',
\ }

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" ---------------------------------------------------------------------------

" ---------------------------------------------------------------------------
"  SYNTASTIC
" ---------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
augroup syntastic_config
  autocmd!
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'
  let g:syntastic_ruby_checkers = ['mri', 'rubocop']
  let g:syntastic_html_tidy_exec = 'tidy5'
augroup END

" ---------------------------------------------------------------------------

" ---------------------------------------------------------------------------
"  AIRLINE
" ---------------------------------------------------------------------------
augroup airline_config
  autocmd!
  let g:airline_powerline_fonts = 1
  let g:airline_enable_syntastic = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
  let g:airline_detect_whitespace=0
  let g:airline_section_warning=""
augroup END

" ---------------------------------------------------------------------------
"  TAGBAR
" ---------------------------------------------------------------------------

" Disable the mouse on Linux
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
	set mouse=
endif

" ---------------------------------------------------------------------------
"  VIM-JAVASCRIPT
" ---------------------------------------------------------------------------
let g:javascript_plugin_jsdoc = 1

" ---------------------------------------------------------------------------
"  FUNCTION: Run NodeJS
" ---------------------------------------------------------------------------
" Repeat last command in the next tmux pane.
" nnoremap <Leader>r :call VimuxRunCommand("clear; node " . expand("%"))<CR>
autocmd Filetype jasmine.javascript nnoremap <Leader>r :Dispatch! npm run test<CR>

" -------------------------------------------------------------------------------
"  OPEN CSI ISSUE
" -------------------------------------------------------------------------------
function! OpenJIRATicket()
	let s:uri = matchstr(getline("."), '[a-Z]*-[0-9]*')
	echo s:uri
	if s:uri != ""
		silent exec "!open 'https://jira.hmhco.com/browse/".s:uri."'"
		redraw!
	else
		echo "No URI found in line."
	endif
endfunction
map <leader>o :call OpenJIRATicket()<cr>

"
" -------------------------------------------------------------------------------
"  Vimux
" -------------------------------------------------------------------------------
let g:VimuxUseNearest = 0
let g:VimuxRunnerType = 'pane'

" -------------------------------------------------------------------------------
"  TERN
" -------------------------------------------------------------------------------
let g:tern_show_argument_hints='on_hold'

let g:tern_map_keys=1
