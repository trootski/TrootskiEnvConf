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

############################################
# Add powerline support
#
POWERLINE_CONFIG_COMMAND="/usr/local/bin/powerline-config"

if [ -f `which powerline-daemon` ]; then
	powerline-daemon -q
	if [[ `which powerline-daemon` =~ ^\/usr\/local\/bin.* ]]; then
		if [ -d '/usr/local/lib/python2.7/site-packages/powerline/' ]; then
			export POWERLINE_LIB_DIR='/usr/local/lib/python2.7/site-packages/powerline/'
		elif [ -d '/usr/local/lib/python2.7/dist-packages/powerline/' ]; then
			export POWERLINE_LIB_DIR='/usr/local/lib/python2.7/dist-packages/powerline/'
		fi
	fi
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	source $POWERLINE_LIB_DIR'bindings/bash/powerline.sh'
fi

