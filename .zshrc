# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

DOTFILES_PATH="$HOME/.dotfiles"

source "$DOTFILES_PATH/scripts/history.zsh"

# prompt settings
autoload -Uz colors
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':completion:*:*:git:*' script "$DOTFILES_PATH/scripts/git-completion.zsh"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:*' formats "%c%u%b%f "
zstyle ':vcs_info:*' actionformats '%F{yellow}%b|%a%f '
zstyle ':vcs_info:git+set-message:*' hooks git-untracked

# dependencies
source "$DOTFILES_PATH/scripts/git-prompt.sh"

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

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# env
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/zip/bin:$PATH"
export PATH="$HOME/.gem/bin:$PATH"

export PATH="$HOME/.custom-commands:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# enable yarn, pnpm
if command -v corepack 1>/dev/null 2>&1; then
  # enable yarn (Node version >= 16.10)
  # run `npm i -g corepack` and restart shell if Node version < 16.10
  corepack enable 1>/dev/null 2>&1
fi

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

# call on every commands
preexec() {
}
precmd() {
  # prompt
  vcs_info
  GIT_PS1_SHOWDIRTYSTATE=true

  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    host="%F{034}%n@%m%f:"
  fi

  PROMPT='
%F{243}[%*]%f \
%B${vcs_info_msg_0_}%b\
${host}%F{039}%~%f
 %B%F{196}>%f%b '
}

# functions
function +vi-git-untracked() {
  # https://qiita.com/mollifier/items/8d5a627d773758dd8078
  if command git status --porcelain 2> /dev/null \
    | awk '{print $1}' \
    | command grep -F '??' > /dev/null 2>&1 ; then

    hook_com[unstaged]+='%F{red}?'
  fi
}

function gibo() {
	if [ -z "$2" ] &&  [ "dump" = "$1" ]; then
		command gibo list | sed -e 's/=== .\+ ===//g' | sed -e 's/\s\+/\n/g' | grep -v '^\s*$' | fzy | xargs -I@ gibo dump @
	else
		command gibo $*
	fi
}

function fzy_history() {
	local cmd=$(history -n -r 1 | fzy --prompt="history > ")
	if [ -n "${cmd}" ]; then
		BUFFER="${cmd}"
	fi
	zle reset-prompt
	# zle accept-line
}
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export DVM_DIR="$HOME/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

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

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
