#!/bin/bash

################################################################################
# If not running interactively, don't do
# anything
#
[ -z "$PS1" ] && return

################################################################################
# Suppress new mail messages
#
unset MAILCHECK

################################################################################
# Configure settings for terminal colour
#
if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi

################################################################################
# Load ~/.prompt, ~/.exports, ~/.aliases and ~/.functions
#
for file in ~/TrootskiEnvConf/bash/{prompt,exports,aliases,functions,completion}.sh; do
    [ -r "$file" ] && source "$file"
done
unset file

################################################################################
# Get some nice sugary syntax highlighting
#
set syntax on

################################################################################
# Setup my PATH
#
export PATH="/usr/local/bin:${HOME}/Documents/bin:$(getconf PATH)"

################################################################################
# From bash 4.3 this should display a different prompt in edit mode
#
set show-mode-in-prompt on

################################################################################
# OS specific config files
#
linux_pat="^linux"
if [[ "$OSTYPE" =~ "$linux_pat" ]]; then
    source ~/TrootskiEnvConf/bash/linux.sh
elif [[ "$OSTYPE" =~ darwin1[0-9] ]]; then
    source ~/TrootskiEnvConf/bash/osx.sh
fi

################################################################################
# See if there are any host specific files
#
if [[ -r ~/TrootskiEnvConf/bash/$(hostname).sh ]]; then
    source ~/TrootskiEnvConf/bash/$(hostname).sh
fi

################################################################################
# Setup NVM home directory
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

################################################################################
# Setup rbenv
#
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
