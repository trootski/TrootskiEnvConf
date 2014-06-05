#!/bin/bash

set -e

# Setup the script on a new machine

[[ ! -e ~/TrootskiEnvConf/backups ]] && mkdir ~/TrootskiEnvConf/backups

if [[ -h ~/.bashrc ]]
then
	rm ~/.bashrc
elif [[ -e ~/.bashrc ]]
then
	# Move the current bashrc to the backup folder
	mv ~/.bashrc ~/TrootskiEnvConf/backups/
fi
ln -s ~/TrootskiEnvConf/bashrc ~/.bashrc

if [[ -h ~/.bash_profile ]]
then
	rm ~/.bash_profile
elif [[ -e ~/.bash_profile ]]
then
	# Move the current bash_profile to the backup folder
	mv ~/.bash_profile ~/TrootskiEnvConf/backups/
fi
ln -s ~/TrootskiEnvConf/bash_profile ~/.bash_profile

if [[ -h ~/.vimrc ]]
then
	rm ~/.vimrc
elif [[ -e ~/.vimrc ]]
then
	# Move the current bash_profile to the backup folder
	mv ~/.vimrc ~/TrootskiEnvConf/backups/
fi
ln -s ~/TrootskiEnvConf/vimrc ~/.vimrc
