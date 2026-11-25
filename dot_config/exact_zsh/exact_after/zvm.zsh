function zvm_after_init() {
	# Fix fzf keybinds.
	if command -v fzf &>/dev/null; then
		# fzf's Tab widget falls back to whatever Tab was bound to; zsh-vi-mode
		# resets that, so point it at fzf-tab explicitly.
		if (($+widgets[fzf-tab-complete])); then
			fzf_default_completion=fzf-tab-complete
		fi
		source <(fzf --zsh)
	fi

	# Bind Ghostty's CSI u encoding of Ctrl+[ to enter normal mode
	zvm_bindkey viins '^[[91;5u' zvm_exit_insert_mode
}
