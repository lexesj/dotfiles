#!/usr/bin/env bash

echo "Installing Neovim plugins..."

if command -v nvim &>/dev/null; then
	echo "Installing Neovim plugins..."
	nvim --headless "+Lazy! sync" +qa
fi
