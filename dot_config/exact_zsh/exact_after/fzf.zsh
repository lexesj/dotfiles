function zvm_after_init() {
	if command -v fzf &>/dev/null; then
		source <(fzf --zsh)
	fi
}
