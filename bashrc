#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export EDITOR='vi'

set syntax on
set -o vi
set showmode

# Machine specific config files
if [ "$HOSTNAME" == "lilacer" ];
then
	source ~/TrootskiEnvConf/ubuntu.sh
elif [[ "$HOSTNAME" == "troot" ]]
then
	source ~/TrootskiEnvConf/troot.sh
elif [[ "$HOSTNAME" == "troot-imac" ]]
then
	source ~/TrootskiEnvConf/troot-imac.sh
fi

HOST_OS=$(uname)

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/TrootskiEnvConf/.{extra,bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

export EDITOR='vi'

set syntax on
PATH="${PATH}:${HOME}/Documents/bin"
export PATH

set -o vi
set showmode

############################################
# You may uncomment the following lines if you want `ls' to be colorized:
#
export CLICOLOR='true'
export LSCOLORS="gxfxcxdxbxegedabagacad"
 
###########################################
# set up aliases
#
alias ll='ls -lagh'
alias l='ls -lagh'
alias grep='grep -n'
alias cd..='cd ..'
alias ..='cd ..'
alias cls='clear'

############################################
# some aliases to set fancy prompts
# see .bash_prompt for further informations
#

if [ -f ~/.bash_styles ];
then
 alias dumb='. ~/.bash_styles dumb'
 alias ice='. ~/.bash_styles ice'
 alias fire='. ~/.bash_styles fire'
 alias nature='. ~/.bash_styles nature'
 alias sunshine='. ~/.bash_styles sunshine'
 alias dream='. ~/.bash_styles dream'
 alias magic='. ~/.bash_styles magic'
 alias testp='. ~/.bash_styles testp'
 alias old='. ~/.bash_styles old'
fi

