# Custom zsh prompt

function git_info() {
  # Check if git is installed
  git --version 2>&1 >/dev/null
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
    CURRENT_K8S_CONTEXT=$(kubectl config view -o jsonpath='{$.current-context}' 2>/dev/null)
    if [ -z "$CURRENT_K8S_CONTEXT" ]; then
        return 1
    fi
    CURRENT_K8S_NAMESPACE=$(kubectl config view -o jsonpath='{$.contexts[?(@.name=="'$CURRENT_K8S_CONTEXT'")].context.namespace}')
    KUBECONFIG_STAGING_ENV=$(expr "$KUBECONFIG" : '.*kubeconfig_k8s-tsg-\([a-z]*\)')
    if [[ "$KUBECONFIG_STAGING_ENV" =~ (dev|int|cert|prod) ]]; then
        echo -n " (k8s:$KUBECONFIG_STAGING_ENV)"
    fi
}

NEWLINE=$'\n'
local git_info_str='$(git_info)'
local k8s_info_str='$(kubectl_env)'
PS1="%B%F{238}%n%F{234}%B@%B%F{238}%M %F{025}%${k8s_info_str} %~%F{238}%F{025}${git_info_str} ${NEWLINE}#%B%F{0} "
PS2=
