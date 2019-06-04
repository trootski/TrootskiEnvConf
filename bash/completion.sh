#!/bin/bash

bash_pattern="bash$"
if [[ "$SHELL" =~ "$bash_pattern" ]]; then
  ############################################
  # Adds tmuxinator bash completion support
  #
  source ~/TrootskiEnvConf/tmuxinator.bash

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

  ############################################
  # Adds tmuxinator bash completion support
  #
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
  	. $(brew --prefix)/etc/bash_completion
  fi

  # This loads nvm bash_completion
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

