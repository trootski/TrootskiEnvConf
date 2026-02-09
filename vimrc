" Define the leader before the plugins are loaded
let mapleader=","

" PLUGINS -------------------------------------------------------------------

set shell=/bin/bash
"set runtimepath^=/home/troot/TrootskiEnvConf/.vim

set nocompatible              " be iMproved, required
filetype off                  " required

if has('nvim')
    call plug#begin('~/.vim/plugged')
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'airblade/vim-gitgutter'
    call plug#end()
else
    set term=xterm
    set t_ut=
    " Standard Vim specific commands
    " set the runtime path to include Vundle and initialize
    set rtp+=~/TrootskiEnvConf/.vim/bundle/Vundle.vim
    
    call vundle#begin()
    
    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'
    
    "  THEMES
    Plugin 'rafi/awesome-vim-colorschemes'
    
    "  UTILITIES
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'christoomey/vim-tmux-navigator'
    
    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
endif


let s:uname = system("echo -n \"$(uname)\"")

" GENERAL -------------------------------------------------------------------

" Remap jj to be the escape keys
ino jj <esc>
cno jj <c-c>

map H ^
map L $

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
    highlight Normal ctermbg=NONE guibg=NONE
  else
    " Terminal / iTerm2
    set bg=light
  endif
endif


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
let g:netrw_banner = 1
let g:netrw_browse_split = 0
let g:netrw_liststyle = 3
map <leader>p :Explore<cr>



