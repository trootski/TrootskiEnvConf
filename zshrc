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
antigen bundle mvn
antigen bundle npm
antigen bundle tmuxinator
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

plugins=(
  docker-compose
  git
  npm
  nvm
  tmuxinator
  z
)

source ~/.antigen/bundles/robbyrussell/oh-my-zsh/oh-my-zsh.sh

# fix for navigation keys in JetBrains terminal
if [[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]; then
  bindkey "∫" backward-word # Option-b
  bindkey "ƒ" forward-word # Option-f
  bindkey "∂" delete-word # Option-d
fi

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey \^U backward-kill-line

case "$OSTYPE" in
  darwin*)
    path+=("/Library/TeX/texbin")
  ;;
esac

export PATH="/usr/local/opt/libpq/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
