#!/bin/bash

############################################
# If not running interactively, don't do
# anything
#
[ -z "$PS1" ] && return

############################################
# Suppress new mail messages
#
unset MAILCHECK

############################################
# Configure settings for terminal colour
#
if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi
alias tmux='tmux -2'  # for 256color
alias tmux='tmux -u'  # to get rid of unicode rendering problem

############################################
# Load ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
#
for file in ~/TrootskiEnvConf/bash/{bash_prompt,exports,aliases,functions}.sh; do
	[ -r "$file" ] && source "$file"
done
unset file

############################################
# Get some nice sugary syntax highlighting
#
set syntax on

############################################
# Setup my PATH
#
export PATH="/usr/local/bin:${HOME}/Documents/bin:$(getconf PATH)"

############################################
# From bash 4.3 this should display a different prompt in edit mode
#
set show-mode-in-prompt on

############################################
# OS specific config files
#
if [ "$OSTYPE" == "linux" ] || [ "$OSTYPE" == "linux-gnu" ]; then
	source ~/TrootskiEnvConf/bash/linux.sh
elif [[ "$OSTYPE" =~ darwin1[0-9] ]]; then
	source ~/TrootskiEnvConf/bash/osx.sh
fi

############################################
# Colour mode for ls
#
export CLICOLOR='true'
export LSCOLORS="gxfxcxdxbxegedabagacad"

############################################
# Adds tmuxinator bash completion support
#
source ~/TrootskiEnvConf/tmuxinator.bash

############################################
# Adds tmuxinator bash completion support
#
export MANWIDTH=120

############################################
# Set default settings for HTML tidy
#
export HTML_TIDY=~/TrootskiEnvConf/html-tidy-config.txt

############################################
# Setup NVM home directory
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

