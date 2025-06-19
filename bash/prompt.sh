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

function kubectl_env() {
    CURRENT_K8S_CONTEXT=$(kubectl config view -o jsonpath='{$.current-context}')
    if [ -z "$CURRENT_K8S_CONTEXT" ]; then
        return 1
    fi
    CURRENT_K8S_NAMESPACE=$(kubectl config view -o jsonpath='{$.contexts[?(@.name=="'$CURRENT_K8S_CONTEXT'")].context.namespace}')
    KUBECONFIG_STAGING_ENV=$(expr "$KUBECONFIG" : '.*kubeconfig_k8s-tsg-\([a-z]*\)')
    #echo $CURRENT_K8S_CONTEXT
    #echo $CURRENT_K8S_NAMESPACE
    #echo $KUBECONFIG_STAGING_ENV
    if [[ "$KUBECONFIG_STAGING_ENV" =~ (dev|int|cert|prod) ]]; then
        echo -n " (k8s:$KUBECONFIG_STAGING_ENV)"
    fi
}

NEWLINE=$'\n'
zsh_pattern="zsh$"
if [[ "$SHELL" =~ "$zsh_pattern" ]]; then
  local git_info_str='$(git_info)'
  local k8s_info_str='$(kubectl_env)'
  PS1="%B%F{238}%n%F{234}%B@%B%F{238}%M %F{025}%${k8s_info_str} %~%F{238}%F{025}${git_info_str} ${NEWLINE}#%B%F{0} "
  PS2=
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

