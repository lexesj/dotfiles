# Add a directory to the front of PATH, removing duplicates.
add_to_path() {
	export PATH="${1}:${PATH//$1:/}"
}

# Delete all nvim swap files.
nvim_clear_swap() {
	local swap_dir="${XDG_STATE_HOME:-$HOME/.local/state}/nvim/swap"
	if [[ -d "$swap_dir" ]]; then
		local count
		count="$(find "$swap_dir" -type f | wc -l | tr -d ' ')"
		rm -f "$swap_dir"/*
		echo "Deleted $count swap file(s) from $swap_dir"
	else
		echo "No swap directory found at $swap_dir"
	fi
}
