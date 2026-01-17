DOTFILES_PATH="$HOME/.dotfiles"

# dependencies
source "$DOTFILES_PATH/scripts/history.zsh"
source "$DOTFILES_PATH/scripts/git-prompt.sh"
source "$DOTFILES_PATH/scripts/prompt.zsh"
source "$DOTFILES_PATH/scripts/pnpm-completion.zsh"

# zplug
source ~/.zplug/init.zsh

if command -v zplug 1>/dev/null 2>&1; then
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "b4b4r07/enhancd", use:init.sh
  zplug "zsh-users/zsh-completions"

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load
else
  echo 'install zplug -> ' 'https://github.com/zplug/zplug#installation'
fi

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)" 1>/dev/null 2>&1
if command -v brew 1>/dev/null 2>&1; then
  export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
fi

# anyenv
if command -v anyenv 1>/dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# direnv
export EDITOR='/usr/bin/nano'
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Google Cloud SDK# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# env
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/zip/bin:$PATH"
export PATH="$HOME/.gem/bin:$PATH"

export PATH="$HOME/.custom-commands:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export DVM_DIR="$HOME/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

# yarn
if command -v yarn 1>/dev/null 2>&1; then
  export PATH="$(yarn global bin):$PATH"
fi

# pnpm
if command -v pnpm 1>/dev/null 2>&1; then
  export PNPM_HOME="$HOME/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi

# alias
alias ls="ls -G"
alias gcc="gcc-12"
alias g++="g++-12"
alias man="env LANG=ja_JP.UTF-8 man"
alias jman="env LANG=ja_JP.UTF-8 man"
alias eman="env LANG=C man"

if command -v http-server 1>/dev/null 2>&1; then
  alias hs='http-server'
fi

# keybinds
zle -N fzy_history
bindkey '^r' fzy_history

# functions
function gibo() {
	if [ -z "$2" ] &&  [ "dump" = "$1" ]; then
		command gibo list | sed -e 's/=== .\+ ===//g' | sed -e 's/\s\+/\n/g' | grep -v '^\s*$' | fzy | xargs -I@ gibo dump @
	else
		command gibo $*
	fi
}

if command -v difft 1>/dev/null 2>&1; then
  export GIT_EXTERNAL_DIFF=difft git diff
fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# kubectl completion
if command -v kubectl 1>/dev/null 2>&1; then
  [[ -f /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
fi

# terraform completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f "$HOME/.anyenv/envs/nodenv/versions/14.15.0/lib/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.zsh" ]] && . "$HOME/.anyenv/envs/nodenv/versions/14.15.0/lib/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.zsh"

# Load Angular CLI autocompletion.
if command -v ng 1>/dev/null 2>&1; then
  source <(ng completion script)
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/tnino/.dart-cli-completion/zsh-config.zsh ]] && . /Users/tnino/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# pnpm
export PNPM_HOME="/Users/tnino/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
