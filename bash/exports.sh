############################################
# General Settings
#

# Make vim the default editor
export EDITOR="vim"

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Ignore Ctrl + d ten times before exiting shell
export IGNOREEOF=10

############################################
# History settings
#

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignorespace:erasedups

# timestamps for bash history. www.debian-administration.org/users/rossen/weblog/1
# saved for later analysis
HISTTIMEFORMAT='%F %T '
export HISTTIMEFORMAT

# Make some commands not show up in history
export HISTIGNORE="cd:cd -:pwd;exit:date:* --help"

############################################
# Set default settings for HTML tidy
#
export HTML_TIDY=~/TrootskiEnvConf/html-tidy-config.txt

############################################
# man settings
#

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Sensible width for man pages
export MANWIDTH=120

############################################
# Colour mode for ls
#
export CLICOLOR='true'
export LSCOLORS="gxfxcxdxbxegedabagacad"

