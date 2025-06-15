#!/usr/bin/env zsh

dotfiles_bin_path="$HOME/.dotfiles/bin"

if [[ -d "dotfiles_bin_path" ]]; then
	add_to_path "dotfiles_bin_path"
fi
