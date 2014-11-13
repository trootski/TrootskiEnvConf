#!/bin/bash

set -e

# Setup the script on a new machine

user_home_path=$HOME

[[ ! -e $user_home_path/backups ]] && mkdir $user_home_path/backups

if [[ -h $user_home_path/.bashrc ]]
then
	rm $user_home_path/.bashrc
elif [[ -e $user_home_path/.bashrc ]]
then
	# Move the current bashrc to the backup folder
	mv $user_home_path/.bashrc $user_home_path/TrootskiEnvConf/backups/
fi
ln -s $user_home_path/TrootskiEnvConf/bashrc $user_home_path/.bashrc

if [[ -h $user_home_path/.bash_profile ]]
then
	rm $user_home_path/.bash_profile
elif [[ -e $user_home_path/.bash_profile ]]
then
	# Move the current bash_profile to the backup folder
	mv $user_home_path/.bash_profile $user_home_path/TrootskiEnvConf/backups/
fi
ln -s $user_home_path/TrootskiEnvConf/bash_profile $user_home_path/.bash_profile

if [[ -h $user_home_path/.vimrc ]]
then
	rm $user_home_path/.vimrc
elif [[ -e $user_home_path/.vimrc ]]
then
	# Move the current bash_profile to the backup folder
	mv $user_home_path/.vimrc $user_home_path/TrootskiEnvConf/backups/
fi
ln -s $user_home_path/TrootskiEnvConf/vimrc $user_home_path/.vimrc
