autoload -Uz compinit promptinit
compinit

setopt promptsubst

source $(brew --prefix)/share/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle npm
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

plugins=(
  git
  npm
  z
)

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Load default dotfiles
source ~/.bashrc
