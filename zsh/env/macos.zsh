export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/zip/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
