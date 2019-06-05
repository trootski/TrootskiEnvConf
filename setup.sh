#!/bin/bash

set -e

############################################
# Make the default linkages for the dot
# files
#
[[ ! -e ~/TrootskiEnvConf/backups ]] && mkdir ~/TrootskiEnvConf/backups

for file in ~/.{bashrc,bash_profile,vimrc,tmuxinator,tmux.conf,ideavimrc,inputrc,zshrc}; do
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
    for pkg in ~/.{awscli,bash-completion,figlet,git,jq,nvm,pv,tidy-html5,tmuxinator-completion,tree,ttygif,watch,tmux,node,python,reattach-to-user-namespace,tig,rbenv}; do
      brew install
    done
    brew install ffmpeg --with-fdk-aac
    brew install vim --wth-override-system-vi --with-python3
    brew cask install disk-inventory-x
    brew cask install graphiql
    brew cask install java
    brew cask install vlc
  fi
elif [[ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr '[:upper:]' '[:lower:]' | tr -d '"') == "ubuntu" ]]; then
  dconf load /org/gnome/terminal/ < ~/TrootskiEnvConf/gnome_terminal_settings_backup.txt
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

