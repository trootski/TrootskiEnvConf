#!/bin/bash

set -e

[[ ! -e ~/TrootskiEnvConf/backups ]] && mkdir ~/TrootskiEnvConf/backups

for file in ~/.{bashrc,bash_profile,vimrc,tmuxinator}; do
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

git submodule update --init ~/TrootskiEnvConf/
