#!/usr/bin/env zsh

function add_to_path() {
	if [[ "$PATH" != *"$1"* ]]; then
		export PATH="$1:$PATH"
	fi
}
