#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Use the vim editor by default
export EDITOR='vim'

# Load ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
for file in ~/TrootskiEnvConf/.{bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Get some nice sugary syntax highlighting
set syntax on

# Setup my PATH
PATH="${PATH}:${HOME}/Documents/bin"
export PATH

# Use vi mode on the command line
set -o vi

# From bash 4.3 this should display a different prompt in edit mode
set show-mode-in-prompt on

# OS specific config files
if [ "$OSTYPE" == "linux" ];
then
	source ~/TrootskiEnvConf/ubuntu.sh
elif [[ "$OSTYPE" == "darwin14" ]]
then
	source ~/TrootskiEnvConf/osx.sh
fi

############################################
# Colour mode for ls
#
export CLICOLOR='true'
export LSCOLORS="gxfxcxdxbxegedabagacad"
 
