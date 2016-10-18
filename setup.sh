#!/bin/bash

set -e

############################################
# Make the default linkages for the dot
# files
#
[[ ! -e ~/TrootskiEnvConf/backups ]] && mkdir ~/TrootskiEnvConf/backups

for file in ~/.{bashrc,bash_profile,vimrc,tmuxinator,tmux.conf,ideavimrc}; do
	if [[ -h "$file" ]]
	then
		# File is a symbolic link
		rm "$file"
	elif [[ -e "$file" ]]
	then
		# File exists, move to the backup folder
		mv "$file" ~/TrootskiEnvConf/backups/
	fi
	echo "Creating symbolic link from "
	echo ~/TrootskiEnvConf/$(echo $(basename "$file") | sed "s/^\.//")
	echo "$file"
	ln -s ~/TrootskiEnvConf/$(echo $(basename "$file") | sed "s/^\.//") "$file"
done


############################################
# On OSX check if we need to install
# brew packages
#
if [[ "$OSTYPE" =~ darwin1[0-9] ]]; then
	which -s brew
	if [[ $? = 0 ]] ; then
		# Install the default packages
		for pkg in ~/.{bash-completion,git,tmux,node,vim,python}; do
			brew install 
		done
	fi
fi

############################################
# Setup the .vim directory
#
ln -s ~/TrootskiEnvConf/.vim ~/.vim

############################################
# Make sure all the submodules are checkout
# out
#
git submodule update --init --recursive
