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
