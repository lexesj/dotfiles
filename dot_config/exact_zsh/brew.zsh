#!/usr/bin/env zsh

if [[ -x "$(command -v brew)" ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi
