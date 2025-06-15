#!/usr/bin/env zsh

if [[ -x "$(command -v zoxide)" ]]; then
	eval "$(zoxide init --cmd cd zsh)"
fi
