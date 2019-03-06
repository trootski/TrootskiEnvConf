# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
    find . -name "$1"
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

# take this repo and copy it to somewhere else minus the .git stuff.
function gitexport(){
	mkdir -p "$1"
	git archive master | tar -x -C "$1"
}

function t_DockerStopAll() {
  docker stop $(docker ps -a -q)
}

function t_PrintPRLogs() {
  local CONFIG_URL=~/.config/printprs/config.json
  local NUM_RECORDS_TO_DISPLAY=$(jq '.NUM_RECORDS_TO_DISPLAY' "$CONFIG_URL" | tr -d '"')
  local PROJECT_FOLDER_DIR=$(jq '.PROJECT_FOLDER_DIR'  "$CONFIG_URL" | tr -d '"')
  local GITHUB_AUTH_TOKEN=$(jq '.GITHUB_AUTH_TOKEN'  "$CONFIG_URL" | tr -d '"')

  ~/TrootskiEnvConf/scripts/hmh-prs.py "$PROJECT_FOLDER_DIR" "$NUM_RECORDS_TO_DISPLAY" "$GITHUB_AUTH_TOKEN"
}

# get gzipped size
function gz() {
	echo "orig size    (bytes): "
	cat "$1" | wc -c
	echo "gzipped size (bytes): "
	gzip -c "$1" | wc -c
}

# All the dig info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# Escape UTF-8 characters into their 3-byte format
function escape() {
	printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
	echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
	echo # newline
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
function extract() {
	if [ -f "$1" ] ; then
		local filename=$(basename "$1")
		local foldername="${filename%%.*}"
		local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
		local didfolderexist=false
		if [ -d "$foldername" ]; then
			didfolderexist=true
			read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
			echo
			if [[ $REPLY =~ ^[Nn]$ ]]; then
				return
			fi
		fi
		mkdir -p "$foldername" && cd "$foldername"
		case $1 in
			*.tar.bz2) tar xjf "$fullpath" ;;
			*.tar.gz) tar xzf "$fullpath" ;;
			*.tar.xz) tar Jxvf "$fullpath" ;;
			*.tar.Z) tar xzf "$fullpath" ;;
			*.tar) tar xf "$fullpath" ;;
			*.taz) tar xzf "$fullpath" ;;
			*.tb2) tar xjf "$fullpath" ;;
			*.tbz) tar xjf "$fullpath" ;;
			*.tbz2) tar xjf "$fullpath" ;;
			*.tgz) tar xzf "$fullpath" ;;
			*.txz) tar Jxvf "$fullpath" ;;
			*.zip) unzip "$fullpath" ;;
			*) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

# Remove all .fla, .html files from a folder
del_flas_and_html() {
	find . -name "*.fla" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
}

function lazygit() {
	git add .
	git commit -a -m "$1"
	git push
}

function t_UpdateTrootskiConf() {
	CURRENT_DIR=$(pwd)
	cd ~/TrootskiEnvConf/
	# Update any submodules
	git submodule foreach git pull origin master
	vim -c VundleInstall -c quitall
	vim -c VundleUpdate -c quitall
	vim -c VundleClean -c quitall
	cd "$CURRENT_DIR"
}

function t_FindProcessUsingPort() {
	lsof -n -i4TCP:$1 | grep LISTEN
}

function t_RGBtoHex() {
	printf \#%02X%02X%02X"\n" "$1" "$2" "$2"
}

############################################
# Video encoding stuff
#

# Encode a mp4 file at a particular bit rate and screen dimensions
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
ffmpeg -y -i "$MP4_FNAME_FULL" -c:v libx264 -s "$MP4_WIDTH":"$MP4_HEIGHT" -preset slow -crf 20 -movflags +faststart -profile:v baseline -level 4.0 -acodec aac -strict experimental -b:a 128k "$MP4_OUT"
#
}

# Take an mp4 and convert it to DASH and HLS
function t_html5_video_suite {

	ORIG_MP4_FNAME_FULL=$(basename "$1")
	ORIG_MP4_FNAME="${ORIG_MP4_FNAME_FULL%.*}"

	# DASH FILES
	t_ffmpeg_bitrate "$1" "350" "320" "240"
	t_ffmpeg_bitrate "$1" "550" "480" "360"
	t_ffmpeg_bitrate "$1" "900" "720" "480"
	t_ffmpeg_bitrate "$1" "1600" "1280" "720"

	MP4_OUT_Q1="$ORIG_MP4_FNAME""-b-350k-320x240.mp4"
	MP4_OUT_Q2="$ORIG_MP4_FNAME""-b-550k-480x360.mp4"
	MP4_OUT_Q3="$ORIG_MP4_FNAME""-b-900k-720x480.mp4"
	MP4_OUT_Q4="$ORIG_MP4_FNAME""-b-1600k-1280x720.mp4"

	OUT_FILE="dash-""$ORIG_MP4_FNAME"".mpd"

	MP4Box -dash 200 -rap -frag-rap -profile onDemand -out "$OUT_FILE" "$MP4_OUT_Q1" "$MP4_OUT_Q2" "$MP4_OUT_Q3" "$MP4_OUT_Q4"

	# HLS segmented file
	ffmpeg -y -i "$MP4_OUT_Q3" -map 0 -codec:v libx264 -acodec aac -strict experimental -f ssegment -segment_list "$ORIG_MP4_FNAME".m3u8 -segment_list_flags +live -segment_time 10 "hls-""$ORIG_MP4_FNAME"%03d.ts

}


