#!/bin/bash

############################################
# Adds tmuxinator bash completion support
#

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

############################################
# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
#
complete -W "NSGlobalDomain" defaults

function t_vlc_conv_snapshot {
	sips -s format jpeg "$1" -s formatOptions 60 -z 720 1280 --out ~/Desktop/thumbnail.jpg
	rm "$1"
}

# TextEdit
# Use Plain Text Mode as Default
#defaults write com.apple.TextEdit RichText -int 0

# Expand Save Panel by Default
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true && \
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true


