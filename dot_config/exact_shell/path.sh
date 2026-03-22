# Local binaries.
if [[ -d "$HOME/.local/bin" ]]; then
	add_to_path "$HOME/.local/bin"
fi

# Nvim Mason binaries.
if [[ -d "$HOME/.local/share/nvim/mason/bin" ]]; then
	add_to_path "$HOME/.local/share/nvim/mason/bin"
fi
