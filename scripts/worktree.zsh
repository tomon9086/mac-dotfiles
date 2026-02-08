# worktree.zsh - git worktree + fzy で選択してcd

# zle版（キーバインド用）
function fzy_worktree() {
  local list
  list=$(git worktree list --porcelain) || return 1
  local wt=$(echo "$list" | grep '^worktree ' | sed 's/^worktree //' | fzy --prompt="worktree > ")
  if [ -n "${wt}" ]; then
    BUFFER="cd ${wt}"
    zle accept-line
  fi
  zle reset-prompt
}

# コマンド版
function _fzy_worktree_cmd() {
  local list
  list=$(git worktree list --porcelain) || return 1
  local wt=$(echo "$list" | grep '^worktree ' | sed 's/^worktree //' | fzy --prompt="worktree > ")
  if [ -n "${wt}" ]; then
    cd "${wt}"
  fi
}

# キーバインド登録
zle -N fzy_worktree
bindkey '^t' fzy_worktree

# エイリアス
alias wt='_fzy_worktree_cmd'

# Copilot CLI 連携
function worktree_copilot() { _fzy_worktree_cmd && copilot }
alias wtc='worktree_copilot'
