#!/bin/bash

# Install Python packages using pipx
# This script will run whenever this file is changed.

if command -v pipx &>/dev/null; then
	echo "Installing Python packages via pipx..."
	pipx install uv || pipx upgrade uv
else
	echo "pipx not found, skipping Python package installation."
fi
