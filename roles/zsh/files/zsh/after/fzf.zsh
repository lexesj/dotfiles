#!/usr/bin/env zsh

if [[ -x "$(command -v fzf)" ]]; then
	source <(fzf --zsh)
fi
