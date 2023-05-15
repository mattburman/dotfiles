export NVM_LAZY_LOAD=true # for lukechilds/zsh-nvm plugin
DOTFILES="$HOME/dotfiles"
alias .z=". ~/.zshrc"
function .f() {
  cd "$DOTFILES/$1"
}

if [[ ! ( $(darkMode) =~ 'Dark' ) ]]; then
  kitty +kitten themes --reload-in=all "Tango Light"
else
  # TODO: fix dark theme
  # kitty +kitten themes --reload-in=all "Tango Dark"
  kitty +kitten themes --reload-in=all "Tango Light"
fi

alias cd-="cd -"

autoload -U compinit && compinit

source ~/.zsh_plugins.sh # generated by script in dotbot install
export TERM=xterm

# Load all of the files in ZSH_PATH/lib that end in .*sh
for file (~/.zsh/lib/*.*sh); do
  source $file
done
# Load all of the files in ZSH_PATH/aliases that end in .*sh
for file (~/.zsh/aliases/*.*sh); do
  source $file
done
source ~/.zsh/submodules/fzf/shell/key-bindings.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
source ~/.zsh/submodules/kubectl-aliases/.kubectl_aliases

if test -e /etc/static/bashrc; then . /etc/static/bashrc; fi 2> /dev/null # import nix bashrc but ignore errors

ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

export PATH=$PATH:.
export PATH=$PATH:$DOTFILES/zsh/path
export PATH=$PATH:/opt/homebrew/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/libpq/bin:$PATH"

alias vim="nvim"
alias v="nvim"
function .v() {
  v "$DOTFILES/$1"
}
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

prompt_hostname() {
  uname | grep -qv "Linux" && return 0 # only prompt if on Linux
  prompt_segment red black
  echo -n $(hostname)
}

prompt_status() {
  echo -n "%(?..%F{red}%?%f)"
}

prompt_path() {
  prompt_segment white black
  echo -n "%~"
}

prompt_time() {
  prompt_segment red black
  echo -n $(date +'%d/%m %X')
}


# prompt random emoji
EMOJIS=(😀 🔥 🍭 📚 ✨ 🎁 🍖 💯 🔸 🔺 🔹 🔻 ◽)
prompt_emoji() {
  echo -n ${EMOJIS[$RANDOM % ${#EMOJIS[@]} + 1]};
}

## Main prompt
build_prompt() {
  echo -n "\n"
  # prompt_emoji
  prompt_status
  prompt_time
  prompt_hostname
  prompt_git
  prompt_path
  prompt_segment
  echo -e '\n$ '
}

function precmd {
  _=$RANDOM # make sure $RANDOM is new each time
  PROMPT="$(build_prompt)"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

uname | grep -q "Darwin" && source ~/.zsh/darwin.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/antigen/antigen.zsh

source /Users/matt/.gvm/scripts/gvm
