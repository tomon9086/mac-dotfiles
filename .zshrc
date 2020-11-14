DOTFILES_PATH="$HOME/.dotfiles"

# prompt settings
autoload -Uz colors
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':completion:*:*:git:*' script "$DOTFILES_PATH/git-completion.zsh"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:*' formats "%c%u%b%f "
zstyle ':vcs_info:*' actionformats '%F{yellow}%b|%a%f '
zstyle ':vcs_info:git+set-message:*' hooks git-untracked

# dependencies
source "$DOTFILES_PATH/git-prompt.sh"

# gvm
__GVM_PATH="$HOME/.gvm/scripts/gvm"
if [ -e "${__GVM_PATH}" ]; then
  source "${__GVM_PATH}"
fi

# anyenv
if command -v anyenv 1>/dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# zplug
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "b4b4r07/enhancd", use:init.sh

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load

# direnv
export EDITOR='/usr/bin/nano'
eval "$(direnv hook zsh)"

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# env
export PATH="$HOME/.custom-commands:$PATH"
export PATH="$HOME/.flutter/bin:$PATH"

# alias
alias ls="ls -G"

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
  PROMPT="
%F{243}[%*]%f \
%B${vcs_info_msg_0_}%b\
%F{039}%~%f
 %B%F{196}>%f%b "
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
export DENO_INSTALL="/Users/t-niino/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export DVM_DIR="/Users/t-niino/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
