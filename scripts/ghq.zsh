# ghq.zsh - ghq + fzy でリポジトリ選択してcd

# zle版（キーバインド用）
function fzy_ghq() {
  local repo=$(ghq list | fzy --prompt="repo > ")
  if [ -n "${repo}" ]; then
    local dir="$(ghq root)/${repo}"
    BUFFER="cd ${dir}"
    zle accept-line
  fi
  zle reset-prompt
}

# コマンド版
function _fzy_ghq_cmd() {
  local repo=$(ghq list | fzy --prompt="repo > ")
  if [ -n "${repo}" ]; then
    cd "$(ghq root)/${repo}"
  fi
}

# キーバインド登録
zle -N fzy_ghq
bindkey '^g' fzy_ghq

# エイリアス
alias g='_fzy_ghq_cmd'

# Copilot CLI 連携
function ghq_copilot() { _fzy_ghq_cmd && copilot }
alias gc='ghq_copilot'
