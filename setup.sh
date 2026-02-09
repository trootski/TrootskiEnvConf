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


if [[ "$OSTYPE" =~ darwin[0-9]{2} ]]; then
  which -s brew
  # Enable it so holding down a key in Intellij will move the cursor smoothly
  defaults write -g ApplePressAndHoldEnabled -bool false
  if [[ $? = 0 ]] ; then
    ############################################
    # On OSX check if we need to install
    # brew packages
    #
    PACKAGE_LIST=$(brew list -1)
    for pkg in {antigen,awscli,ffmpeg,figlet,git,jq,python,reattach-to-user-namespace,tidy-html5,tig,tmux,tmuxinator,tmuxinator-completion,tree,ttygif,vim,watch}; do
      brew list "$pkg" || brew install "$pkg"
    done

    for pkg in {keepassx,postman}; do
      brew list --cask "$pkg" || brew install --cask "$pkg"
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
  command -v zsh >/dev/null 2>&1 || sudo apt install -y zsh
  if [ ! -f /usr/share/zsh-antigen/antigen.zsh ]; then
      echo "Setting up zsh-antigen"
      sudo mkdir -p /usr/share/zsh-antigen
      sudo curl -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen
  fi

  ############################################
  # Install some default packages
  #
  for pkg in {figlet,git,jq,python3,rbenv,tig,tmux,tmuxinator,tree,watch}; do
      dpkg-query -W "$pkg" >/dev/null 2>/dev/null || sudo apt install -y "$pkg"
  done

  ############################################
  # Map Caps Lock to Control
  #
  gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

  ############################################
  # Navigate to workspaces
  #
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Ctrl><Alt>1']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Ctrl><Alt>2']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Ctrl><Alt>3']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Ctrl><Alt>4']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Ctrl><Alt>5']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Ctrl><Alt>6']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Ctrl><Alt>7']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Ctrl><Alt>8']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Ctrl><Alt>9']"
  gsettings set org.gnome.desktop.interface enable-animations false

  ############################################
  # Install neovim, this is required for
  # some vim plugins
  #
  if [ pip3 show neovim >/dev/null 2>&1 ]; then
      echo "Installing neovim pip package"
      pip3 install neovim
  fi

fi

############################################
# Install NVM
#
command -v nvm >/dev/null 2>&1 && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

############################################
# Setup the .vim directory
#
# Remove the ~/.vim folder if it exists and is not a symbolic link
[[ -d ~/.vim ]] && ! [[ -h ~/.vim ]] && rm -rf ~/.vim
ln -sfv ~/TrootskiEnvConf/.vim ~/.vim

############################################
# Setup the ~/.config/nvim/ directory
#
# Remove the ~/.vim folder if it exists and is not a symbolic link
[[ -d ~/.config/nvim ]] && ! [[ -h ~/.config/nvim ]] && rm -rf ~/.config/nvim
mkdir -p ~/.config
ln -sfv ~/TrootskiEnvConf/nvim ~/.config/nvim

############################################
# Setup the .tmuxinator directory
#
# Remove the ~/.vim folder if it exists and is not a symbolic link
# [[ -d ~/.tmuxinator ]] && ! [[ -h ~/.tmuxinator ]] && rm -rf ~/.tmuxinator
# ln -sfv ~/TrootskiEnvConf/tmuxinator ~/.tmuxinator

############################################
# Make sure all the submodules are checked
# out
#
# SUBMODULE_STATUS=$(git submodule status)
# 
# # Check if any of the modules have been checked out, if so just update them
# if [[ "$SUBMODULE_STATUS" =~ $'\n'.*\+ || "$SUBMODULE_STATUS" =~ .*\+ ]]; then
#     git submodule update --remote --rebase --recursive
# else
#     git submodule update --init --remote --recursive
# fi

