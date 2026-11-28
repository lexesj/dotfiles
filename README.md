# dotfiles

Stores my configs and setup for my developer environments.

## Quick Start

To set up your environment on a new machine, run the following command:

```bash
bash -c "$(curl -fsLS https://raw.githubusercontent.com/lexesj/dotfiles/main/bin/setup)"
```

This script will:

- Install `chezmoi` if it's not already installed (using Homebrew on macOS or a direct binary download on Linux).
- Initialize `chezmoi` from the [lexesj/dotfiles](https://github.com/lexesj/dotfiles.git) repository.
- Update and apply the configuration, which includes:
  - Installing Homebrew packages and casks on macOS.
  - Downloading and installing essential binaries on Linux.
  - Linking and templating your configuration files (Neovim, Zsh, Git, etc.).

### Windows

Run the following in PowerShell:

```pwsh
irm https://raw.githubusercontent.com/lexesj/dotfiles/main/bin/setup.ps1 | iex
```

This installs Git, PowerShell 7 and `chezmoi` with `winget`, then applies the configuration: `winget` packages, PowerShell modules and profile, Windows Terminal, PowerToys, Git and Claude Code. Afterwards, run `chezmoi update` to pull and apply changes.

PowerToys and Command Palette settings are `modify_` templates that set only the keys we manage, so the state those apps write doesn't drift. Windows Terminal and Keyboard Manager are plain copies: after changing them in the app's UI, run `chezmoi re-add` to bring the changes into the repo.

## Requirements

- `curl`
- `git`
- `brew` (for macOS)
- `winget` (for Windows)
