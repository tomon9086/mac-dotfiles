export PATH="$HOME/.gem/bin:$PATH"
export PATH="$HOME/.custom-commands:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export DVM_DIR="$HOME/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

# yarn
if command -v yarn 1>/dev/null 2>&1; then
  export PATH="$(yarn global bin):$PATH"
fi

# serverless
export PATH="$HOME/.serverless/bin:$PATH"

# difft
if command -v difft 1>/dev/null 2>&1; then
  export GIT_EXTERNAL_DIFF=difft
fi
