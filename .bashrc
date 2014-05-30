# ~/.bashrc: executed by bash(1) for non-login shells.

# If we are on ubuntu, do the default setup first
if [ -f ~/TrootskiEnvConf/.ubuntu ];
then
	source ~/TrootskiEnvConf/.ubuntu
fi

export PS1='\u@\h:\w\n> '
umask 022

##########################################
#setting up file completion
#

if [ -f ~/.bash_completion ];
then
        . ~/.bash_completion;
fi

##########################################
# advanced prompt settings
#

if [ -f ~/.bash_styles ];
then
        . ~/.bash_styles old;
fi

#export NNTPSERVER='news.unina.it'
export EDITOR='vi'

set syntax on
PATH="/usr/local/bin:/usr/include:${PATH}:${HOME}/node_modules/less/bin:${HOME}/node_modules/node-dev:${HOME}/Documents/flex_sdk/bin"
export PATH

set -o vi
set showmode

############################################
# You may uncomment the following lines if you want `ls' to be colorized:
#

# export CLICOLOR='true'
# export LSCOLORS="gxfxcxdxbxegedabagacad"
 
###########################################
# set up aliases
#
 
alias ll='ls -lagh'
alias l='ls -lagh'
alias grep='grep -n'
alias netconns='netstat -a -f inet'
alias cd..='cd ..'
alias ..='cd ..'
alias work='cd ~/working'
alias dl='cd /volumes/hd4/" downloads"'
alias d4='cd /volumes/hd4'
alias cls='clear'
alias skyp='env PULSE_LATENCY_MSEC=60 skype %U'
# alias vi='vim'
# alias c++='g++'
# alias cc='gcc'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
alias ttop='top -ocpu -R -F -s 2 -n30'

############################################
# some aliases to set fancy prompts
# see .bash_prompt for further informations
#

if [ -f ~/.bash_styles ];
then
 alias dumb='. ~/.bash_styles dumb'
 alias ice='. ~/.bash_styles ice'
 alias fire='. ~/.bash_styles fire'
 alias nature='. ~/.bash_styles nature'
 alias sunshine='. ~/.bash_styles sunshine'
 alias dream='. ~/.bash_styles dream'
 alias magic='. ~/.bash_styles magic'
 alias testp='. ~/.bash_styles testp'
 alias old='. ~/.bash_styles old'
fi
#source /sw/bin/init.sh

