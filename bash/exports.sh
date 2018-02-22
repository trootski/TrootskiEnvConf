############################################
# General Settings
#

# Make vim the default editor
export EDITOR="vim"

# Prefer GB English and use UTF-8
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB"


############################################
# History settings
#

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

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

