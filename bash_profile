# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Prefer GB English and use UTF-8
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Include the bashrc
[[ -s ~/.bashrc ]] && source ~/.bashrc
