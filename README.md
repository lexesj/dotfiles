# dotfiles

Stores my configs and setup for my developer environments.

## Quick Start

To set up your environment on a new machine, run the following command:

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/lexesj/dotfiles/lexes/migrate-to-chezmoi/bin/setup)"
```

This script will:

- Install `chezmoi` if it's not already installed (using Homebrew on macOS or a direct binary download on Linux).
- Initialize `chezmoi` from the [lexesj/dotfiles](https://github.com/lexesj/dotfiles.git) repository.
- Apply the configuration, which includes:
  - Installing Homebrew packages and casks on macOS.
  - Downloading and installing essential binaries on Linux.
  - Linking and templating your configuration files (Neovim, Zsh, Git, etc.).

## Requirements

- `curl`
- `git`
- `brew` (for macOS)
