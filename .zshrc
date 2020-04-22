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
export PATH="$PATH:$HOME/.custom-commands"

# alias
alias ls="ls -G"

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
