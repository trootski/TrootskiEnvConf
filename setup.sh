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
		for pkg in ~/.{bash-completion,git,tmux,node,python,reattach-to-user-namespace,tig}; do
			brew install 
		done
		brew install ffmpeg --with-fdk-aac
		brew install vim --wth-override-system-vi --with-python3
		brew install disk-inventory-x
	fi
fi

############################################
# Setup the .vim directory
#
ln -s ~/TrootskiEnvConf/.vim ~/.vim

############################################
# Soft link the powerline directory
#
if [ ! -f ~/.config/powerline ]; then
	mkdir -p ~/.config/
	ln -s ~/TrootskiEnvConf/powerline ~/.config/powerline
fi

############################################
# Make sure all the submodules are checkout
# out
#
git submodule foreach git pull origin master
