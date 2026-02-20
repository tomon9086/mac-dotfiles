# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)" 1>/dev/null 2>&1
if command -v brew 1>/dev/null 2>&1; then
  export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
fi
