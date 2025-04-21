#!/usr/bin/env zsh

ZSH_CONFIG_DIR="$HOME/.config/zsh"
ZSH_CONFIG_HOOKS=("before" "" "after")

for hook in "${ZSH_CONFIG_HOOKS[@]}"; do
  dir="$ZSH_CONFIG_DIR"
  if [[ -n $hook ]]; then
    dir+="/$hook"
  fi
  for file in "$dir"/*.zsh; do
    source "$file"
  done
done
