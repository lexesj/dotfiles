function zvm_after_init() {
	# Fix fzf keybinds.
	if command -v fzf &>/dev/null; then
		source <(fzf --zsh)
	fi

	# Bind Ghostty's CSI u encoding of Ctrl+[ to enter normal mode
	zvm_bindkey viins '^[[91;5u' zvm_exit_insert_mode
}
