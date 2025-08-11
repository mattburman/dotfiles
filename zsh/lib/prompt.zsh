# Prompt configuration and functions
autoload -Uz add-zsh-hook

# Define the segment separator
SEGMENT_SEPARATOR=' '

# Function to get git status synchronously
function _get_git_status() {
  # Check if we're in a git repo
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo ""
    return
  fi

  local ref staged unstaged_tracked untracked
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
  ref=${ref#refs/heads/}

  # Parse git status output
  local status_output
  status_output=$(git status --porcelain -uno 2> /dev/null)

  # Check for staged changes (M/A/D/R/C in first column)
  if echo "$status_output" | grep -E '^[MADRC]' > /dev/null; then
    staged=" %{%F{yellow}%}●%{%F{252}%}"  # Yellow dot for staged changes
  else
    staged=""
  fi

  # Check for unstaged changes to tracked files (M/A/D/R/C in second column)
  if echo "$status_output" | grep -E '^.[MADRC]' > /dev/null; then
    unstaged_tracked=" %{%F{red}%}●%{%F{252}%}"  # Red dot for unstaged changes to tracked files
  else
    unstaged_tracked=""
  fi

  untracked="" # Always empty with -uno

  # If no changes at all, show clean symbol
  if [[ -z "$staged" && -z "$unstaged_tracked" && -z "$untracked" ]]; then
    staged=" %{%F{green}%}✓%{%F{252}%}"
  fi

  echo -n "${ref}${staged}${unstaged_tracked}${untracked}"
}

# Synchronous git prompt
prompt_git() {
  local git_info
  git_info=$(_get_git_status) # Synchronous call
  if [[ -n "$git_info" ]]; then
    prompt_segment 238 252 # Colors for the git segment
    echo -n "$git_info"
  fi
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    [[ $CURRENT_BG != 'NONE' ]] && echo -n " "
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n "$3 "
}

prompt_kubens() {
  command -v kubens >/dev/null 2>&1 || return
  kns="$(kubens --current)"
  [ -z "$kns" ] && return
  prompt_segment blue white
  echo -n "$kns "
}

prompt_hostname() {
  uname | grep -qv "Linux" && return 0 # only prompt if on Linux
  prompt_segment red black
  echo -n $(hostname)
}

prompt_status() {
  local symbols=""
  local exit_code=${1:-$?}

  # Show error code with symbol and description
  if [[ $exit_code -ne 0 ]]; then
    case $exit_code in
      127) symbols+="%{%F{red}%}✘ cmd not found%{%f%} ";;  # Command not found
      126) symbols+="%{%F{red}%}✘ not executable%{%f%} ";;  # Not executable
      1)   symbols+="%{%F{red}%}✘ error%{%f%} ";;  # General error
      *)   symbols+="%{%F{red}%}✘ $exit_code%{%f%} ";;  # Other error codes
    esac
  fi

  # Show background jobs count with symbol
  local job_count=$(jobs -l | wc -l | tr -d ' ')
  if [[ $job_count -gt 0 ]]; then
    symbols+="%{%F{cyan}%}⚙ ${job_count}%{%f%} "
  fi

  # Show sudo timestamp
  # if sudo -n true 2>/dev/null; then # Temporarily commented out
  #   symbols+="%{%F{yellow}%}⚡%{%f%} "
  # fi

  echo -n "$symbols"
}

prompt_path() {
  prompt_segment white black
  echo -n "%~"
}

prompt_time() {
  prompt_segment black white
  echo -n "$(date +'%d/%m %X')"
}

# prompt random emoji
EMOJIS=(😀 🔥 🍭 📚 ✨ 🎁 🍖 💯 🔸 🔺 🔹 🔻 ◽)
prompt_emoji() {
  echo -n ${EMOJIS[$RANDOM % ${#EMOJIS[@]} + 1]};\n}

## Main prompt
build_prompt() {
  local last_exit_status=$1
  CURRENT_BG='NONE'
  echo -n "\n"
  # prompt_emoji
  prompt_status "$last_exit_status"
  prompt_time
  prompt_hostname
  prompt_git
  # prompt_kubens
  prompt_path

  [[ -n $CURRENT_BG ]] && echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  echo -n "%{%f%}"
  echo -e '\n$ '
}

function precmd {
  local last_exit_status=$?
  _=$RANDOM # make sure $RANDOM is new each time
  PS1="$(build_prompt $last_exit_status)"
  # Also set PROMPT as a fallback
  PROMPT=$PS1
}

# Clear git status cache when running git commands (No longer needed with sync prompt)
# function preexec {
#   if [[ $2 == git* ]]; then
#     CACHED_GIT_STATUS="" # CACHED_GIT_STATUS is removed
#   fi
# }
# No add-zsh-hook for precmd update_git_status or chpwd update_git_status needed
# No TRAPINT for async_stop_worker needed
