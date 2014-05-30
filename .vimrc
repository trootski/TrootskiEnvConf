
set runtimepath^=~/TrootskiEnvConf/.vim/

scriptencoding utf-8

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set clipboard=unnamedplus
set nobackup
set nowritebackup

"
" Undo
"
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=1000

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85
"colorscheme solarized

set list
set listchars=tab:▸\ ,eol:¬

set modeline	" enable modelines to be read
set nocompatible
set bs=2		" allow backspacing over everything

set ruler		" show current coords of cursor
set nu			" line numbering

set ttymouse=xterm2		" allows mouse to work in screen sessions
set mouse=a		" allow mouse support in console

set bg=dark

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


" enable filetype plugins
filetype plugin on
filetype indent on

" Funny file extensions
autocmd BufRead,BufNewFile *.spv setlocal filetype=php
autocmd BufRead,BufNewFile *.pxl setlocal filetype=python
autocmd BufRead,BufNewFile *.pxlt setlocal filetype=python

" HTML / XML / XSL shouldn't be wrapped - makes it too hard to see indentation
autocmd FileType html,xml,xslt,php setlocal nowrap

syntax enable " syntax highlighting
syntax on

" ToDo keywords
syn keyword Todo contained TODO FIX FIXME XXX HACK
syn keyword pythonTodo contained TODO FIX FIXME XXX HACK

"
" Function key mappings
"
nmap <silent> <F4> :set invhlsearch<CR> " Toggle search highlighting

" F5 toggles the invpaste setting - 
" this stops auto-indentation going nuts when you paste stuff in terminal
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5>

nmap <silent> <F6> :set invlist<CR> " Toggle whitespace display
            

" Edit/save another file in the same directory as the current file
" uses expression to extract path from current file's path
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,sp :sp <C-R>=expand("%:p:h") . "/" <CR>
map ,vsp :vsp <C-R>=expand("%:p:h") . "/" <CR>
map ,w :w <C-R>=expand("%:p:h") . "/" <CR>
map ,sav :sav <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Ctrl arrows to move between windows
noremap <Esc>[1;5D <C-W><Left>
noremap <Esc>[1;5C <C-W><Right>
noremap <Esc>[1;5A <C-W><Up>
noremap <Esc>[1;5B <C-W><Down>

noremap <C-Left>  <C-W><Left>
noremap <C-Right> <C-W><Right>
noremap <C-Up>    <C-W><Up>
noremap <C-Down>  <C-W><Down>

" Move text, but keep selection
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" NERD_tree should ignore .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$']
map <F2> :NERDTreeToggle<CR>

au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
autocmd BufRead *.as set filetype=actionscript

" -------------------------------------------------------------------------------
"  LESS FUNCS
" -------------------------------------------------------------------------------

function LessToCss()
	let current_file = shellescape(expand('%:p'))
	let filename = shellescape(expand('%:r'))
	let filenamestub = shellescape(expand('%:r:r'))
	
	" Setup the filename check for a bootstrap file
	let bootstrapstub = expand('%:p:h:h') . "/css/bootstrap.css"
	let bootstraplessstub = expand('%:p:h') . "/bootstrap.less"
	
	" Setup the filename for the same file in a css directory
	let cssname = expand('%:p:h:h') . '/css/' . expand('%:t:r') . '.css'
	
	if filereadable(bootstrapstub) && filereadable(bootstraplessstub)
		let command = "silent !lessc -x " . bootstraplessstub . " " . bootstrapstub
	elseif filereadable(cssname)
		let command = "silent !lessc -x " . current_file . " " . cssname
	else
		let command = "silent !lessc -x " . current_file . " " . filename . ".css"
	endif
	execute command
endfunction
autocmd BufWritePost,FileWritePost *.less call LessToCss()

" -------------------------------------------------------------------------------

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
set runtimepath^=~/.vim/bundle/ctrlp.vim
" -------------------------------------------------------------------------------
