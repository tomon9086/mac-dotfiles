DOTFILES_PATH="${0:a:h}"

case "$OSTYPE" in
  darwin*) DOTFILES_OS="macos" ;;
  linux*)  DOTFILES_OS="linux" ;;
esac

# Helper: source <OS>.zsh then common.zsh from a directory
_source_os() {
  local dir="$1"
  [[ -f "$dir/${DOTFILES_OS}.zsh" ]] && source "$dir/${DOTFILES_OS}.zsh"
  [[ -f "$dir/common.zsh" ]] && source "$dir/common.zsh"
}

_source_os "$DOTFILES_PATH/zsh/alias"
_source_os "$DOTFILES_PATH/zsh/completion"
_source_os "$DOTFILES_PATH/zsh/editor"
_source_os "$DOTFILES_PATH/zsh/env"
_source_os "$DOTFILES_PATH/zsh/function"
_source_os "$DOTFILES_PATH/zsh/ghq"
_source_os "$DOTFILES_PATH/zsh/git-prompt"
_source_os "$DOTFILES_PATH/zsh/history"
_source_os "$DOTFILES_PATH/zsh/keybind"
_source_os "$DOTFILES_PATH/zsh/plugin"
_source_os "$DOTFILES_PATH/zsh/prompt"
_source_os "$DOTFILES_PATH/zsh/tools"
_source_os "$DOTFILES_PATH/zsh/worktree"
