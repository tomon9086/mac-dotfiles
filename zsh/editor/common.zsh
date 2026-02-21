CLI_EDITOR='vi'

if command -v vim 1>/dev/null 2>&1; then
  CLI_EDITOR='vim'
fi

if command -v nvim 1>/dev/null 2>&1; then
  CLI_EDITOR='nvim'
fi

export EDITOR="$CLI_EDITOR"
