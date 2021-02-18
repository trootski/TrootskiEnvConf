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


if [[ "$OSTYPE" =~ darwin1[0-9] ]]; then
  which -s brew
  if [[ $? = 0 ]] ; then
    ############################################
    # On OSX check if we need to install
    # brew packages
    #
    PACKAGE_LIST=$(brew list -1)
    for pkg in {awscli,figlet,git,jq,tidy-html5,tmuxinator-completion,tree,ttygif,watch,tmux,python,reattach-to-user-namespace,tig,rbenv}; do
      brew list "$pkg" || brew install "$pkg"
    done

    brew list ffmpeg || brew install ffmpeg -- --with-fdk-aac --with-freetype --with-libass --with-libvpx
    brew list vim || brew install vim -- --wth-override-system-vi --with-python3

    for pkg in {java8,vlc,mactex,sequel-pro,transmit,visual-studio-code,keepassx}; do
      brew cask list "$pkg" || brew cask install "$pkg"
    done
  fi
elif [[ $(awk -F= '/^NAME/{print $2}' /etc/os-release | tr '[:upper:]' '[:lower:]' | tr -d '"') == "ubuntu" ]]; then
  ############################################
  # Load the terminal colour scheme
  #
  if [ command -v dconf >/dev/null 2>&1 ]; then
      echo "Setting colour profile for terminal"
      dconf load /org/gnome/terminal/ < ~/TrootskiEnvConf/gnome_terminal_settings_backup.txt
  fi

  ############################################
  # Setup zsh as the default shell and 
  # install zsh antigen
  #
  command -v zsh >/dev/null 2>&1 || sudo apt install zsh
  if [ ! -f /usr/share/zsh-antigen/antigen.zsh ]; then
      echo "Setting up zsh-antigen"
      sudo mkdir -p /usr/share/zsh-antigen
      sudo curl -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen
  fi

  ############################################
  # Install some default packages
  #
  for pkg in {awscli,figlet,git,jq,python,python3-pip,rbenv,tig,tmux,tmuxinator,tree,watch}; do
      dpkg-query -W "$pkg" >/dev/null 2>/dev/null || sudo apt install "$pkg"
  done

  ############################################
  # Install neovim, this is required for
  # some vim plugins
  #
  if [ pip3 show neovim >/dev/null 2>&1 ]; then
      echo "Installing neovim pip package"
      pip3 install neovim
  fi

  ############################################
  # Install NVM
  #
  command -v nvm >/dev/null 2>&1 && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
fi

############################################
# Setup the .vim directory
#
# Remove the ~/.vim folder if it exists and is not a symbolic link
[[ -d ~/.vim ]] && ! [[ -h ~/.vim ]] && rm -rf ~/.vim
ln -sfv ~/TrootskiEnvConf/.vim ~

############################################
# Make sure all the submodules are checked
# out
#
git submodule update --remote --rebase --recursive

