setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

zshaddhistory() {  
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  # add current command to history when it return 0
  [[ "$line" =~ ($HOME) ]] && return 1
  [[ "$line" =~ (/bin/python -m pip install) ]] && return 1

  return 0
}
