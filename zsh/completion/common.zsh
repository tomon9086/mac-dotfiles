COMPLETION_SCRIPTS_DIR="$DOTFILES_PATH/zsh/completion"

# Add scripts dir to fpath for custom completions (_git, etc.)
fpath=("$COMPLETION_SCRIPTS_DIR/scripts" $fpath)

# Initialize completion system
autoload -Uz compinit && compinit

# pnpm completion
if command -v pnpm 1>/dev/null 2>&1; then
  source "$COMPLETION_SCRIPTS_DIR/scripts/pnpm-completion.zsh"
fi

# tabtab source for packages
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# kubectl completion
if command -v kubectl 1>/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# terraform completion
if command -v terraform 1>/dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "$(command -v terraform)" terraform
fi

# Angular CLI
if command -v ng 1>/dev/null 2>&1; then
  source <(ng completion script)
fi

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
