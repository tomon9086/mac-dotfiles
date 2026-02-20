autoload -Uz colors
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':completion:*:*:git:*' script "$DOTFILES_PATH/zsh/git-completion.zsh"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:*' formats "%c%u%b%f "
zstyle ':vcs_info:*' actionformats '%F{yellow}%b|%a%f '
zstyle ':vcs_info:git+set-message:*' hooks git-untracked

# Use precmd_functions array instead of overriding precmd (avoid duplicate registration)
if [[ ! " ${precmd_functions[@]} " =~ " setup_prompt " ]]; then
  precmd_functions+=(setup_prompt)
fi

setup_prompt() {
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

function +vi-git-untracked() {
  # https://qiita.com/mollifier/items/8d5a627d773758dd8078
  if command git status --porcelain 2> /dev/null \
    | awk '{print $1}' \
    | command grep -F '??' > /dev/null 2>&1 ; then

    hook_com[unstaged]+='%F{red}?'
  fi
}
