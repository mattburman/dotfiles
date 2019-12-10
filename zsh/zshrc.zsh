# Load all of the files in ZSH_PATH/lib that end in .zsh
for file (~/.zsh/lib/*.zsh); do
  source $file
done
# Load all of the files in ZSH_PATH/aliases that end in .zsh
for file (~/.zsh/aliases/*.zsh); do
  source $file
done
source ~/.zsh/submodules/fzf/shell/key-bindings.zsh
source ~/.zsh/submodules/kubectl-aliases/.kubectl_aliases

source ~/.nix-profile/etc/profile.d/nix.sh
if test -e /etc/static/bashrc; then . /etc/static/bashrc; fi 2> /dev/null # import nix bashrc but ignore errors

ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

export EDITOR=vim
export VISUAL=vim
export SHELL=$(which zsh)

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  SEGMENT_SEPARATOR=' '
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

prompt_git() {
  (( $+commands[git] )) || return
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_random() {
  prompt_segment yellow black
  echo -n "test"
}

prompt_status() {
  echo -n "%(?..%F{red}%?%f)"
}

prompt_exec() {
  prompt_segment
  echo -n "%~💲 "
}

## Main prompt
build_prompt() {
  prompt_status
  prompt_git
  prompt_exec
  prompt_segment
}
build_rprompt() {
}

function precmd {
  PROMPT="$(build_prompt)"
  RPROMPT="$(build_rprompt)"
}

