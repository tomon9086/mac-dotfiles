# anyenv
if command -v anyenv 1>/dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# direnv
export EDITOR='/usr/bin/nano'
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# difft
if command -v difft 1>/dev/null 2>&1; then
  export GIT_EXTERNAL_DIFF=difft git diff
fi
