setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Store the last executed command (excluding + commands)
LAST_COMMAND=""
IS_SAVING_TO_HISTORY=0

# Use preexec hook to capture commands (avoid duplicate registration)
if [[ ! " ${preexec_functions[@]} " =~ " capture_last_command " ]]; then
  preexec_functions+=(capture_last_command)
fi

capture_last_command() {
  local cmd="$1"
  # Don't store + commands themselves as last command
  if [[ ! "$cmd" =~ '^\+' ]]; then
    LAST_COMMAND="$cmd"
  fi
}

zshaddhistory() {  
  # Allow commands that are explicitly being saved by +
  if [[ $IS_SAVING_TO_HISTORY -eq 1 ]]; then
    IS_SAVING_TO_HISTORY=0
    return 0
  fi
  # Prevent all other commands from being saved to default history
  return 1
}

# Function to add command to history
add_to_history() {
  local cmd_to_save="$1"
  if [[ -n "$cmd_to_save" ]]; then
    IS_SAVING_TO_HISTORY=1
    print -s "$cmd_to_save"
    echo "Added to history: $cmd_to_save"
  fi
}

# + command function
+() {
  if [[ $# -eq 0 ]]; then
    # No arguments: save the last command
    if [[ -n "$LAST_COMMAND" ]]; then
      add_to_history "$LAST_COMMAND"
    else
      echo "No previous command to save"
    fi
  else
    # Arguments provided: execute the command and save it
    local cmd_to_execute="$*"
    eval "$cmd_to_execute"
    local exit_code=$?
    add_to_history "$cmd_to_execute"
    return $exit_code
  fi
}

# Function to search history with fzy
function fzy_history() {
	local cmd=$(history -n -r 1 | fzy --prompt="history > ")
	if [ -n "${cmd}" ]; then
		BUFFER="${cmd}"
	fi
	zle reset-prompt
	# zle accept-line
}
