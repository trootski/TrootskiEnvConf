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

function t_ffmpeg_bitrate {

	MP4_FNAME_FULL=$(basename "$1")
	MP4_FNAME="${MP4_FNAME_FULL%.*}"

	BITRATE=550
	if [ "$#" -gt 1 ]; then
		BITRATE="$2"
	fi

	MP4_WIDTH=1280
	if [ "$#" -gt 2 ]; then
		MP4_WIDTH="$3"
	fi

	MP4_HEIGHT=720
	if [ "$#" -gt 3 ]; then
		MP4_HEIGHT="$4"
	fi

	MP4_OUT="$MP4_FNAME""-b-""$BITRATE""k-""$MP4_WIDTH""x""$MP4_HEIGHT"".mp4"

	#echo "Encoding ""$MP4_FNAME"". Dimensions: ""$MP4_WIDTH"":""$MP4_HEIGHT"". Bitrate (""$BITRATE"")"
	echo "Creating ""$MP4_OUT"

	# MP4 @ provided bit rate (default: 550)
	ffmpeg -y -i "$MP4_FNAME_FULL" -c:v libx264 -s "$MP4_WIDTH":"$MP4_HEIGHT" -preset slow -b:v "$BITRATE"k -pass 1 -movflags +faststart -profile:v baseline -level 4.0 -acodec aac -strict experimental -b:a 128k -f mp4 /dev/null && ffmpeg -y -i "$MP4_FNAME_FULL" -c:v libx264 -s "$MP4_WIDTH":"$MP4_HEIGHT" -preset slow -b:v "$BITRATE"k -pass 2 -movflags +faststart -profile:v baseline -level 4.0 -acodec aac -strict experimental -b:a 128k "$MP4_OUT"
#
}

# TextEdit
# Use Plain Text Mode as Default
#defaults write com.apple.TextEdit RichText -int 0

# Expand Save Panel by Default
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true && \
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true


