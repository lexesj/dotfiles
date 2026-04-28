function zvm_after_init() {
	# Fix fzf keybinds.
	if command -v fzf &>/dev/null; then
		source <(fzf --zsh)
	fi

	# Restore Ctrl+[ → normal mode after fzf may have clobbered the binding
	zvm_bindkey viins '^[' zvm_exit_insert_mode
}
