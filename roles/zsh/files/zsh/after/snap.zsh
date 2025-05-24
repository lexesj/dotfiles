#!/usr/bin/env zsh

if [[ -x "$(command -v snap)" ]]; then
	add_to_path /snap/bin
fi
