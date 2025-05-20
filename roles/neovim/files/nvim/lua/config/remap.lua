vim.g.mapleader = " "

-- move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "go to upper window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "go to lower window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "go to right window", remap = true })

vim.keymap.set("n", "<leader>l", vim.cmd.Lazy, { desc = "open lazy" })
