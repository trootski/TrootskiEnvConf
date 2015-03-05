#!/bin/bash

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
if [[ $OSTYPE == darwin* ]]; then 
  complete -W "NSGlobalDomain" defaults
fi

