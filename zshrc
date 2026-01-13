# Load shared shell configs
for file in ~/TrootskiEnvConf/shell/{exports,aliases,functions}.sh; do
    [ -r "$file" ] && source "$file"
done
unset file

# Load OS-specific configs
case "$OSTYPE" in
  darwin*)
    [ -r ~/TrootskiEnvConf/shell/darwin.sh ] && source ~/TrootskiEnvConf/shell/darwin.sh
  ;;
  linux*)
    [ -r ~/TrootskiEnvConf/bash/linux.sh ] && source ~/TrootskiEnvConf/bash/linux.sh
  ;;
esac

# Load host-specific and local configs
[ -r ~/TrootskiEnvConf/bash/$(hostname).sh ] && source ~/TrootskiEnvConf/bash/$(hostname).sh
[ -r ~/TrootskiEnvConf/bash/local.sh ] && source ~/TrootskiEnvConf/bash/local.sh

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=32768
SAVEHIST=32768
setopt EXTENDED_HISTORY          # Write timestamps to history
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_IGNORE_ALL_DUPS      # Remove older duplicate entries from history
setopt HIST_FIND_NO_DUPS         # Don't display duplicates when searching
setopt SHARE_HISTORY             # Share history between sessions
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording

# Useful zsh options
setopt AUTO_CD                   # cd by typing directory name if it's not a command
setopt AUTO_PUSHD                # Make cd push old directory onto directory stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicate directories onto stack
setopt PUSHD_SILENT              # Don't print directory stack after pushd/popd
setopt EXTENDED_GLOB             # Use extended globbing syntax
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shells
setopt PROMPT_SUBST              # Enable parameter expansion in prompts

if command -v brew &>/dev/null; then
  BREW_PATH=$(brew --prefix)
  eval "$($BREW_PATH/bin/brew shellenv)"
fi

autoload -Uz compinit promptinit

for dump in ~/.zcompdump(N.mh+24); do
    compinit
done

compinit -C

case `uname` in
  Darwin)
    source $BREW_PATH/share/antigen/antigen.zsh
  ;;
  Linux)
    source /usr/share/zsh-antigen/antigen.zsh
 ;;
esac

antigen use oh-my-zsh

# Load plugins
antigen bundle command-not-found
antigen bundle git
antigen bundle mvn
antigen bundle npm
antigen bundle tmuxinator
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

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

export PATH="/usr/local/bin:/opt/homebrew/opt/libpq/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#zprof

# Set up fzf key bindings and fuzzy completion
if command -v fzf &>/dev/null && fzf --zsh &>/dev/null; then
  source <(fzf --zsh)
fi

# Load custom zsh prompt
[ -r ~/TrootskiEnvConf/zsh/prompt.sh ] && source ~/TrootskiEnvConf/zsh/prompt.sh
