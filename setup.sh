#!/bin/bash

set -e

############################################
# Make the default linkages for the dot
# files
#
for file in ~/.{bash_profile,bashrc,ideavimrc,inputrc,tmux_theme,tmux.conf,vimrc,zshrc}; do
  if ! [[ -f "$file" ]]; then
    # File is not a symbolic link, remove it
    rm -f "$file"
  fi
  echo "Creating symbolic link from "~/TrootskiEnvConf/$(echo $(basename "$file") | sed "s/^\.//") "$file"
  ln -sf ~/TrootskiEnvConf/$(echo $(basename "$file") | sed "s/^\.//") "$file"
done


############################################
# On OSX check if we need to install
# brew packages
#
if [[ "$OSTYPE" =~ darwin1[0-9] ]]; then
  which -s brew
  if [[ $? = 0 ]] ; then
    # Install the default packages
    PACKAGE_LIST=$(brew list -1)
    for pkg in {awscli,bash-completion,figlet,git,jq,tidy-html5,tmuxinator-completion,tree,ttygif,watch,tmux,node,python,reattach-to-user-namespace,tig,rbenv}; do
      brew list "$pkg" || brew install "$pkg"
    done

    brew list ffmpeg || brew install ffmpeg -- --with-fdk-aac --with-freetype --with-libass --with-libvpx
    brew list vim || brew install vim -- --wth-override-system-vi --with-python3

    for pkg in {disk-inventory-x,graphiql,java8,vlc,mactex,sequel-pro,transmit,visual-studio-code,keepassx,intellij-idea-ce}; do
      brew cask list "$pkg" || brew cask install "$pkg"
    done
  fi
elif [[ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr '[:upper:]' '[:lower:]' | tr -d '"') == "ubuntu" ]]; then
  dconf load /org/gnome/terminal/ < ~/TrootskiEnvConf/gnome_terminal_settings_backup.txt
fi

############################################
# Setup the .vim directory
#
# Remove the ~/.vim folder if it exists and is not a symbolic link
[[ -d ~/.vim ]] && ! [[ -h ~/.vim ]] && rm -rf ~/.vim
ln -sfv ~/TrootskiEnvConf/.vim ~

############################################
# Make sure all the submodules are checkout
# out
#
git submodule update --init --recursive

