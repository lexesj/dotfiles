-- Line number settings.
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab settings.
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Global clipboard.
vim.opt.clipboard = "unnamedplus"

-- Decrease update time.
vim.opt.updatetime = 250

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

-- Enable spell checking.
vim.opt.spell = true
