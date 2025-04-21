#!/usr/bin/env zsh

for file in "$HOME"/.config/zsh/*.zsh; do
  source "$file"
done
