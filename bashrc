#!/bin/bash

############################################
# If not running interactively, don't do
# anything
#
[ -z "$PS1" ] && return

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
PATH="${PATH}:${HOME}/Documents/bin:${HOME}/.local/bin"

if [ -d "~/.composer/vendor/bin/" ]; then
	PATH="${PATH}:${HOME}/.composer/vendor/bin"
fi
export PATH

############################################
# Use vi mode on the command line
#
set -o vi

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


