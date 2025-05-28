#!/usr/bin/env zsh

fnm_path="$HOME/.local/share/fnm"

if [[ -d "$fnm_path" ]]; then
  add_to_path "$fnm_path"
fi

eval "$(fnm env --use-on-cd --shell zsh)"
