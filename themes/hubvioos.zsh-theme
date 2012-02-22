if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi

PROMPT='
%{$fg[$NCOLOR]%}∞ %{$fg[cyan]%}$(get_hostname)%{$reset_color%} %{$fg[yellow]%}$(get_pwd)%{$reset_color%}$(git_prompt_info) %B%(!.#.$)%b $(put_spacing)%{$reset_color%} $(get_time)
→ '

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*"

function get_hostname() {
  echo %n@%m
}

function get_pwd() {
  print -D ${PWD/#$HOME/~}
}

function get_time() {
  echo '[%*]'
}

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function put_spacing() {
  local termwidth
  (( termwidth = ${COLUMNS} - 27 - ${#$(get_hostname)} - ${#$(get_pwd)} - ${#$(get_time)} - ${#$(git_prompt_info)} ))
  
  local spacing=""
  for i in {1..$termwidth}; do
    spacing="${spacing}-" 
  done
  echo $spacing
}