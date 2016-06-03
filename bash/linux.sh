############################################
# Setup my PATH (Linux specific)
#
PATH="${PATH}:${HOME}/.composer/vendor/bin"
export PATH

POWERLINE_CONFIG_COMMAND=${HOME}"/.local/bin/powerline-config"

if [ -f `which powerline-daemon` ]; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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

function t_html5_video_suite {

	ORIG_MP4_FNAME_FULL=$(basename "$1")
	ORIG_MP4_FNAME="${ORIG_MP4_FNAME_FULL%.*}"

	# DASH FILES
	#t_ffmpeg_bitrate "$1" "350" "320" "240"
	#t_ffmpeg_bitrate "$1" "550" "480" "360"
	t_ffmpeg_bitrate "$1" "900" "720" "480"
	#t_ffmpeg_bitrate "$1" "1600" "1280" "720"

	#MP4_OUT_Q1="$ORIG_MP4_FNAME""-b-350k-320x240.mp4"
	#MP4_OUT_Q2="$ORIG_MP4_FNAME""-b-550k-480x360.mp4"
	MP4_OUT_Q3="$ORIG_MP4_FNAME""-b-900k-720x480.mp4"
	#MP4_OUT_Q4="$ORIG_MP4_FNAME""-b-1600k-1280x720.mp4"

	OUT_FILE="dash-""$ORIG_MP4_FNAME"".mpd"

	#MP4Box -dash 200 -rap -frag-rap -profile onDemand -out "$OUT_FILE" "$MP4_OUT_Q1" "$MP4_OUT_Q2" "$MP4_OUT_Q3" "$MP4_OUT_Q4"

	# HLS segmented file
	ffmpeg -y -i "$MP4_OUT_Q3" -map 0 -codec:v libx264 -acodec aac -strict experimental -f ssegment -segment_list "$ORIG_MP4_FNAME".m3u8 -segment_list_flags +live -segment_time 10 "hls-""$ORIG_MP4_FNAME"%03d.ts

}

function t_convert_all {
	unset a i
	while IFS= read -r -d $'\0' file; do
		echo "$file"
		a[i++]="$file"
	done < <(find /media/sf_Sites/showcase.brando.ie/htdocs -type f -name '*.mp4' -print0)

	for f in "${a[@]}"; do
		MP4_FNAME_FULL=$(basename "$f")
		MP4_FNAME="${MP4_FNAME_FULL%.*}"
		cd "$(dirname "$f")"
		t_html5_video_suite "$MP4_FNAME_FULL"
	done
}

function t_a {
	if [ "$#" -eq 1 ]; then
		SESS="$1"
	else
		SESS=0
	fi

	tmux attach -t "$SESS"
}

t_apache_logs() {
	sudo tail -f /var/log/apache2/error.log
}

function t_karma_init_headless_display() {
	if $(command -v karma >/dev/null 2>&1) ; then
		export DISPLAY=:99.0
		export CHROME_BIN=/usr/bin/chromium-browser
		test -e /tmp/.X99-lock || sudo /usr/bin/Xvfb :99 &
	fi
}

