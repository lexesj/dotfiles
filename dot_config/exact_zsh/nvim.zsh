#!/usr/bin/env zsh

# Empty the nvim LSP log file.
nvim-clear-lsp-log() {
	local log="${XDG_STATE_HOME:-$HOME/.local/state}/nvim/lsp.log"
	if [[ -f "$log" ]]; then
		: >"$log"
		echo "Cleared $log"
	else
		echo "No lsp.log found at $log"
	fi
}

# Delete all nvim swap files.
nvim-clear-swap() {
	local swap_dir="${XDG_STATE_HOME:-$HOME/.local/state}/nvim/swap"
	if [[ -d "$swap_dir" ]]; then
		local count=$(find "$swap_dir" -type f | wc -l | tr -d ' ')
		rm -f "$swap_dir"/*
		echo "Deleted $count swap file(s) from $swap_dir"
	else
		echo "No swap directory found at $swap_dir"
	fi
}
