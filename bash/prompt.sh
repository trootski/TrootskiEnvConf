# @gf3’s Sexy Bash Prompt, inspired by “Extravagant Zsh Prompt”
# Shamelessly copied from https://github.com/gf3/dotfiles

function git_info() {
  # Check if git is installed
  git --version 2>&1 >/dev/null # improvement by tripleee
  GIT_IS_AVAILABLE=$?
  if [ $GIT_IS_AVAILABLE -eq 0 ]; then
    # check if we're in a git repo
    git rev-parse --is-inside-work-tree &>/dev/null || return
    # quickest check for what branch we're on
    local branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
    # check if it's dirty (via github.com/sindresorhus/pure)
    local dirty=$(git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ]&& echo -e "*")
    if [[ "$TERMINAL_EMULATOR" = "JetBrains-JediTerm" ]]; then
      echo " on "$branch$dirty
    else
      echo " on "$branch$dirty
    fi
  fi
}

zsh_pattern="zsh$"
if [[ "$SHELL" =~ "$zsh_pattern" ]]; then
  local git_info_str='$(git_info)'
  if [[ "$TERMINAL_EMULATOR" = "JetBrains-JediTerm" ]]; then
    PS1="%B%F{238}%n%B@%B%F{238}%M %F{025}%~%F{238}%F{025}${git_info_str}"$'\n'"# %B%F{0}"
    PS2=
  else
    PS1="%B%F{238}%n%F{234}%B@%B%F{238}%M %F{025}%~%F{238}%F{025}${git_info_str}"$'\n'"# %B%F{0}"
    PS2=
  fi
elif [ -e "$POWERLINE_CONFIG_COMMAND" ]; then
	PROMPT_COMMAND="$PROMPT_COMMAND"
else
	if [ -t 1 ]; then

		if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
			export TERM=gnome-256color
		elif infocmp xterm-256color >/dev/null 2>&1; then
			export TERM=xterm-256color
		fi

		# Only show username/host if not default
		function usernamehost() {
			echo "${GRAY}$USER${WHITE}@${GRAY}$HOSTNAME $WHITEin "
		}

		if [[ $EUID -ne 0 ]]; then
			# We are not root
			PS1="\[\e]2;$PWD\[\a\]\[\e]1;\]$(basename "$(dirname "$PWD")")/\W\[\a\]${BOLD}\$(usernamehost)\[$PURPLE\]\w\$(git_info)\[$WHITE\]\n# \[$RESET\]"
		else
			# We are root
			PS1='\h:\W \u\$ '
		fi

	fi

fi

