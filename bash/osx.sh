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

function t_ffmpeg_split {

	MP4_FNAME_FULL=$(basename "$1")
	MP4_FNAME_BASE="${MP4_FNAME_FULL%.*}"
	MP4_FNAME_EXT=${MP4_FNAME_FULL##*.}

	DURATION=$(ffprobe -i "$MP4_FNAME_FULL" -show_entries format=duration -v quiet -of csv="p=0")

	PARTS=1
	if [ "$#" -gt 1 ]; then
		PARTS="$2"
	fi

	if [ "$PARTS" -eq 1 ]; then
		echo "Parts must be higher than 1"
	else
		TIME_PER_PART=$(awk -v duration="$DURATION" -v parts="$PARTS" 'BEGIN { rounded = sprintf("%.0f", duration/parts); print rounded }')
		COUNTER=1
		printf -v COUNTER_LEADING_ZEROS "%05d\n" $COUNTER
		MOVIE_PART_FNAME="$MP4_FNAME_BASE-$COUNTER_LEADING_ZEROS.$MP4_FNAME_EXT"
		ffmpeg -y -i "$MP4_FNAME_FULL" -ss 0 -t $TIME_PER_PART "$MOVIE_PART_FNAME"
		while [[ $COUNTER -lt $PARTS ]]; do
			NEXT_COUNTER=$(($COUNTER+1))
			printf -v COUNTER_LEADING_ZEROS "%05d\n" $NEXT_COUNTER
			MOVIE_PART_FNAME="$MP4_FNAME_BASE-$COUNTER_LEADING_ZEROS.$MP4_FNAME_EXT"
			ffmpeg -y -i "$MP4_FNAME_FULL" -ss $(($TIME_PER_PART*$COUNTER)) -t $(($TIME_PER_PART*$NEXT_COUNTER)) "$MOVIE_PART_FNAME"
			let COUNTER=( COUNTER + 1 )
		done
	fi

}

# TextEdit
# Use Plain Text Mode as Default
#defaults write com.apple.TextEdit RichText -int 0

# Expand Save Panel by Default
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true && \
#defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true


