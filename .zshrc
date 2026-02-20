DOTFILES_PATH="$HOME/.dotfiles"

# OS detection
case "$(uname -s)" in
  Darwin) DOTFILES_OS="macos" ;;
  Linux)  DOTFILES_OS="linux" ;;
esac

# Helper: source <OS>.zsh then common.zsh from a directory
_source_os() {
  local dir="$1"
  [[ -f "$dir/${DOTFILES_OS}.zsh" ]] && source "$dir/${DOTFILES_OS}.zsh"
  [[ -f "$dir/common.zsh" ]] && source "$dir/common.zsh"
}

# base scripts
source "$DOTFILES_PATH/scripts/history.zsh"
source "$DOTFILES_PATH/scripts/git-prompt.sh"
source "$DOTFILES_PATH/scripts/prompt.zsh"
source "$DOTFILES_PATH/scripts/pnpm-completion.zsh"
source "$DOTFILES_PATH/scripts/ghq.zsh"
source "$DOTFILES_PATH/scripts/worktree.zsh"

# plugins
source "$DOTFILES_PATH/scripts/plugin.zsh"

# tools, env, aliases, completions
_source_os "$DOTFILES_PATH/scripts/tools"
_source_os "$DOTFILES_PATH/scripts/env"
_source_os "$DOTFILES_PATH/scripts/alias"
_source_os "$DOTFILES_PATH/scripts/completion"

# keybinds
source "$DOTFILES_PATH/scripts/keybind.zsh"

# functions
source "$DOTFILES_PATH/scripts/function.zsh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
