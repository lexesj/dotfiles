#!/bin/bash

# Ensure fnm is in path (it should be since it's installed via brew or external)
if [[ -d "$HOME/.local/bin" ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

if command -v fnm &>/dev/null; then
	echo "Setting up latest Node.js version..."
	fnm install --latest
	fnm default latest
else
	echo "fnm not found. Skipping node installation."
fi
