# dotfiles

Stores my configs and setup for my developer environments, now managed with **chezmoi**.

## Usage

Run the following to set up your environment:

```bash
./bin/setup
```

This will:
- Install `chezmoi` if it's not already installed.
- Initialize `chezmoi` using the current directory as the source.
- Apply the configuration, which includes:
    - Installing Homebrew packages and casks on macOS.
    - Downloading and installing essential binaries on Linux (Ubuntu).
    - Linking and templating your configuration files (Neovim, Zsh, Git, etc.).

## Requirements
- `curl`
- `git`
- `brew` (for macOS)
