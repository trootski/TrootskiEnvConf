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

POWERLINE_CONFIG_COMMAND="/usr/local/bin/powerline-config"

if [ -f `which powerline-daemon` ]; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	source /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi

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


