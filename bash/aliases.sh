###########################################
# GENERAL ALIASES
#

alias cls='clear'
alias vi='vim'
alias vim='vimx'

# Get info to use vim key bindings
alias info='info --vi-keys'

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
alias flush="sudo killall -HUP mDNSResponder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

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
# CD ALIASES
#

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

###########################################
# HISTORY ALIASES
#

# grep history
alias gh="history -a; history -n; history | grep"

###########################################
# DOCKER
#
alias dl='docker ps -l -q'
alias dlc='dl | pbcopy'

###########################################
# TREE
#
alias tree='tree -C'

###########################################
# TMUX
#
alias tmux='tmux -2u'  # for 256 color and get rid of unicode rendering problem
alias mux='tmuxinator'
alias attach='tmux attach -t '

