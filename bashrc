#!/bin/bash

############################################
# If not running interactively, don't do
# anything
#
[ -z "$PS1" ] && return

############################################
# Use the vim editor by default
#
if hash nvim 2>/dev/null; then
	export EDITOR='nvim'
else
	export EDITOR='vim'
fi

############################################
# Load ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
#
for file in ~/TrootskiEnvConf/bash/{bash_prompt,exports,aliases,functions}; do
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
PATH="${PATH}:${HOME}/Documents/bin:"
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
if [ "$OSTYPE" == "linux" ] || [ "$OSTYPE" == "linux-gnu" ];
then
	source ~/TrootskiEnvConf/bash/linux.sh
elif [[ "$OSTYPE" == "darwin14" ]]
then
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
