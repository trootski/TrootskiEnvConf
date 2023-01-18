" Define the leader before the plugins are loaded
let mapleader=","

" PLUGINS -------------------------------------------------------------------

set shell=/bin/bash
"set runtimepath^=/home/troot/TrootskiEnvConf/.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/TrootskiEnvConf/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"  INTERFACE STUFF
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'mhinz/vim-signify'

"  THEMES
Plugin 'rafi/awesome-vim-colorschemes'

"  UTILITIES
Plugin 'mattn/emmet-vim'
Plugin 'honza/vim-snippets'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'marcweber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-dispatch'

"  SYNTAX/LANGUAGE SUPPORT
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'groenewege/vim-less'
Plugin 'sophacles/vim-processing'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'markcornick/vim-vagrant'
Plugin 'rodjek/vim-puppet'
Plugin 'burnettk/vim-angular'
Plugin 'claco/jasmine.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
Plugin 'jparise/vim-graphql'
Plugin 'tpope/vim-cucumber'
Plugin 'pylint.vim'

"  CODE COMPLETION
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let s:uname = system("echo -n \"$(uname)\"")

" GENERAL -------------------------------------------------------------------

" Remap jj to be the escape keys
ino jj <esc>
cno jj <c-c>

set pastetoggle=<Leader>o

syntax enable

let g:airline_solarized_bg='light'
if s:uname == "Linux"
  let lines = readfile("/proc/version")
  highlight Normal ctermbg=NONE guibg=NONE
  set background=light
  if lines[0] =~ "microsoft"
    " WSL2
    colorscheme gruvbox
  else
    " Normal Linux
  endif
else
  " MacOS
  colorscheme gruvbox
  if $TERMINAL_EMULATOR != "JetBrains-JediTerm"
    " Intellij IDEA
    set background=light
    highlight Normal ctermbg=230 guibg=#ffffd7
  else
    " Terminal / iTerm2
    set bg=dark
  endif
endif

set term=xterm
set t_ut=

" let g:gruvbox_contrast_light = 'hard'
" yank to clipboard
if has("clipboard")
  " copy to the system clipboard
  set clipboard^=unnamed

  " X11 support
  if has("unnamedplus")
    set clipboard+=unnamedplus
  endif
endif
set nopaste
set go+=a

set autoindent
set backspace=indent,eol,start

" allow backspacing over everything
set bs=2

if version >= 703
  set colorcolumn=120
endif

set cursorline

" Break lines on words, not characters
set linebreak
set formatoptions=qrn1
set hidden
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬

" enable modelines to be read
set modeline

" allow mouse support in console
set mouse=
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

" line numbering
set nu

if version >= 703
  set relativenumber
endif

" show current coords of cursor
set ruler
set scrolloff=3
set showcmd

" Always display the tabline, even if there is only one tab
set showtabline=2

" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

" Always display the statusline in all windows
set laststatus=2

set visualbell
set wildmenu
set wildmode=list:longest
set wrap

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

" case insensitive searching"
set ignorecase

" search as you type
set noincsearch

"
" Tabbing

" auto indent on new line"
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

" use spaces by default
set expandtab

" Enable automatic comment leaders
set formatoptions=ro

" set the title of the terminal to the name of the file you are editing
set title
set titleold=""

" command line completion
set wildmode=list:longest,full

" Edit/save another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>sp :sp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>vsp :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>w :w <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>sav :sav <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Stop the exit to CLI when hitting up accidentally
vnoremap K k

" Spell check git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" Execute command on this line and replace with results of command
noremap Q !!sh<CR>

autocmd Filetype javascript,json nnoremap <Leader>x :%!python -m json.tool
autocmd Filetype html nnoremap <Leader>x :%!tidy -mi -wrap 0 2>/dev/null<CR>
autocmd BufNewFile,BufRead *.aurora set syntax=python

if !has("gui_running")
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
endif


" ---------------------------------------------------------------------------
"  NERD TREE STUFF
" ---------------------------------------------------------------------------
let NERDTreeIgnore=['\.pyc$', '\~$']
map <Leader>f :NERDTreeToggle<CR>

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

" Jump to buffer number
nnoremap gj :buffer

" Delete the current buffer but don't close the window
nnoremap gd :bp\|bd #<CR>

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

" Remap clear cache (no F5 with touch bar)
map <leader>C :CtrlPClearCache<cr>

if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif

set wildignore+=*/bower_components/*,
set wildignore+=*/node_modules/*,
set wildignore+=*/vendor/*,
set wildignore+=*/app_deploy/*,
set wildignore+=*/dist/*,

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|node_modules|dist|app_deploy|bower_components|vendor|components)$',
  \ 'file': '\v\.(exe|so|dll|so|swp|zip|jpg|jpeg|png|gif)$',
\ }

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

map <leader>R :CtrlPClearCache<cr>

" ---------------------------------------------------------------------------
"  FOLDING
" ---------------------------------------------------------------------------
set foldcolumn=0 " Column to show folds
set foldenable " Enable folding
set foldmethod=syntax " Syntax are used to specify folds
set foldminlines=0 " Allow folding single lines
set foldnestmax=5 " Set max fold nesting level
set foldlevel=20 " Close all folds by default
set foldlevelstart=20

autocmd FileType text setlocal foldmethod=marker foldlevelstart=0 foldlevel=0

autocmd FileType text  map <leader>ccf zO$vi{V"+yzC

" ---------------------------------------------------------------------------

" ---------------------------------------------------------------------------
"  AIRLINE
" ---------------------------------------------------------------------------
augroup airline_config
  autocmd!
  let g:airline_theme='sol'
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
  let g:airline_detect_whitespace=0
  let g:airline_section_warning=""
augroup END

" ---------------------------------------------------------------------------
"  TAGBAR
" ---------------------------------------------------------------------------

" Disable the mouse on Linux
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
autocmd Filetype javascript nnoremap <Leader>t :Make <CR>
autocmd Filetype javascript nnoremap <Leader>r :Dispatch npm run start<CR>
autocmd Filetype jasmine.javascript nnoremap <Leader>r :Dispatch npm run test<CR>
autocmd FileType javascript silent! compiler node | setlocal makeprg=node\ %

"
" -------------------------------------------------------------------------------
"  Vimux
" -------------------------------------------------------------------------------
let g:VimuxUseNearest = 0
let g:VimuxRunnerType = 'pane'

" -------------------------------------------------------------------------------
"  LaTex
" -------------------------------------------------------------------------------
imap <C-g> <Plug>IMAP_JumpForward
nmap <C-g> <Plug>IMAP_JumpForward

let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 1
let g:gruvbox_contrast_dark = 'medium'

let NERDTreeMinimalUI = 1

" -------------------------------------------------------------------------------
"  VIM-SIGNIFY
" -------------------------------------------------------------------------------
let g:signify_vcs_list = [ 'git' ]

" -------------------------------------------------------------------------------
"  NETRW
" -------------------------------------------------------------------------------
let g:netrw_banner = 0

