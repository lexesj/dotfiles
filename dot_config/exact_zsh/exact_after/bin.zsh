#!/usr/bin/env zsh

local_bin_path="$HOME/.local/bin"

if [[ -d "$local_bin_path" ]]; then
	add_to_path "$local_bin_path"
fi
