vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Global clipboard.
vim.opt.clipboard = "unnamedplus"

-- Decrease update time.
vim.opt.updatetime = 250

vim.opt.spell = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Show white space characters.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Make splits predictable.
vim.o.splitright = true
vim.o.splitbelow = true
