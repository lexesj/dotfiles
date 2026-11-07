-- Options that differ from LazyVim's defaults:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Tab settings.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Global clipboard, also over SSH (LazyVim disables it there).
vim.opt.clipboard = "unnamedplus"

-- Over SSH, use OSC 52 so paste reads the local clipboard. Inside tmux, Neovim would otherwise use
-- tmux's paste buffer, which copying updates but pasting never syncs from the local clipboard.
if vim.env.SSH_CONNECTION then
	vim.g.clipboard = "osc52"
end

-- Preview substitutions in a split.
vim.opt.inccommand = "split"

-- Show white space characters.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Override default LazyVim no-wrap.
vim.opt.wrap = true

-- Diff mode force-disables wrap regardless of 'wrap'; make it respect our setting.
vim.opt.diffopt:append("followwrap")

-- JavaScript / TypeScript settings.
vim.g.lazyvim_ts_lsp = "tsc"
vim.g.lazyvim_prettier_needs_config = true
