DOTFILES_PATH="${0:a:h}"

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
source "$DOTFILES_PATH/zsh/history.zsh"
source "$DOTFILES_PATH/zsh/git-prompt.sh"
source "$DOTFILES_PATH/zsh/prompt.zsh"
source "$DOTFILES_PATH/zsh/pnpm-completion.zsh"
source "$DOTFILES_PATH/zsh/ghq.zsh"
source "$DOTFILES_PATH/zsh/worktree.zsh"

# plugins
source "$DOTFILES_PATH/zsh/plugin.zsh"

# tools, env, aliases, completions
_source_os "$DOTFILES_PATH/zsh/tools"
_source_os "$DOTFILES_PATH/zsh/env"
_source_os "$DOTFILES_PATH/zsh/alias"
_source_os "$DOTFILES_PATH/zsh/completion"

# keybinds
source "$DOTFILES_PATH/zsh/keybind.zsh"

# functions
source "$DOTFILES_PATH/zsh/function.zsh"
