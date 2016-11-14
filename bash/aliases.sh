###########################################
# GENERAL ALIASES
#

alias cls='clear'

# `cat` with beautiful colors. requires Pygments installed.
# 							   sudo easy_install Pygments
alias c='pygmentize -O style=monokai -f console256 -g'

# If nvim exists, make it the default shell
#if hash nvim 2>/dev/null; then
#	alias vim='nvim'
#	alias vi='nvim'
#fi
alias vi='vim'

###########################################
# GIT STUFF
#

# Do a git add everything
alias gga="git add ."

# Do a git add absolutely everything
alias ggaa="git add -A"

# Do git commit with editor
alias ggc="git commit"

# Do git commit with message
alias ggm="git commit -a -m "

# Do git push
alias ggp="git push"

# Do git pull
alias ggg="git pull"

# Do git status
alias ggs="git status"

# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# git root
alias ggr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'

###########################################
# GLOBAL COMMAND ALIASES
#

# be nice
alias hosts='sudo $EDITOR /etc/hosts'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"


# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
type -t hd > /dev/null || alias hd="hexdump -C"

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
done

###########################################
# LINUX SPECIFIC ALIASES
#
if [ "$OSTYPE" == "linux" ] || [ "$OSTYPE" == "linux-gnu" ]; then

	alias ls="command ls --color"

	export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

fi

###########################################
# OSX SPECIFIC ALIASES
#
if [[ "$OSTYPE" =~ ^darwin ]]; then

	alias ls="command ls -G"

	# OS X has no `md5sum`, so use `md5` as a fallback
	type -t md5sum > /dev/null || alias md5sum="md5"

	# Trim new lines and copy to clipboard
	alias trimcopy="tr -d '\n' | pbcopy"

	# Recursively delete `.DS_Store` files
	alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

	# File size
	alias fs="stat -f \"%z bytes\""

	# Empty the Trash on all mounted volumes and the main HDD
	alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"

	# Hide/show all desktop icons (useful when presenting)
	alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
	alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

	# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
	alias plistbuddy="/usr/libexec/PlistBuddy"

	# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
	alias stfu="osascript -e 'set volume output muted true'"
	alias pumpitup="osascript -e 'set volume 10'"
	alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

fi

###########################################
# LS ALIASES
#
# Standard list long
alias ll="ls -lgh ${colorflag}"

# List all files colorized
alias l="ls -h ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -lah ${colorflag}"

# List only directories
alias lsd='ls -l | grep "^d"'

###########################################
# LS COLOUR SETUP
#
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

###########################################
# CD ALIASES
#
# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias ..='cd ..'