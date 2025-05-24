#!/usr/bin/env zsh

mason_bin_path="$HOME/.local/share/nvim/mason/bin"

if [[ -d "$mason_bin_path" ]]; do
  add_to_path "$mason_bin_path"
fi
