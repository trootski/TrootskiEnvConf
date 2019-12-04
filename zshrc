# Load default dotfiles
source ~/.bashrc

autoload -Uz compinit promptinit
compinit

setopt promptsubst


case `uname` in
  Darwin)
    source $(brew --prefix)/share/antigen/antigen.zsh
  ;;
  Linux)
    source /usr/share/zsh-antigen/antigen.zsh
 ;;
esac

antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle git
antigen bundle npm
antigen bundle tmuxinator
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

plugins=(
  git
  npm
  tmuxinator
  z
)

source ~/.antigen/bundles/robbyrussell/oh-my-zsh/oh-my-zsh.sh

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey \^U backward-kill-line

