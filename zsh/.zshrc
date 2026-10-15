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

autoload -Uz compinit promptinit
fpath=(~/.zsh/completions $fpath)
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done

function t_FindProcessUsingPort() {
  lsof -n -i4TCP:$1 | grep LISTEN
}

function jwtd() {
  if [[ -x $(command -v jq) ]]; then
    jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< "${1}"
    echo "Signature: $(echo "${1}" | awk -F'.' '{print $3}')"
  fi
}
compinit -C


source ~/.local/bin/antigen.zsh

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

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey \^U backward-kill-line

export PATH="$HOME/.local/bin:$HOME/.local/ruby/bin:$(python3 -m site --user-base)/bin:$PATH"
export DYLD_LIBRARY_PATH="$HOME/.local/lib:$DYLD_LIBRARY_PATH"
export SSL_CERT_FILE=~/.local/share/ca-bundle.pem
export REQUESTS_CA_BUNDLE=~/.local/share/ca-bundle.pem


export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Set up fzf key bindings and fuzzy completion
if command -v fzf &>/dev/null && fzf --zsh &>/dev/null; then
  source <(fzf --zsh)
fi

alias vi='nvim'
alias vim='nvim'
# Load custom zsh prompt
[ -r ~/.prompt.sh ] && source ~/.prompt.sh


