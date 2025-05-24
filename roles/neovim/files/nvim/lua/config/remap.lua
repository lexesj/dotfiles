vim.g.mapleader = " "

vim.keymap.set("n", "<leader>l", vim.cmd.Lazy, { desc = "open lazy" })

-- Change split size.
vim.keymap.set("n", "<M-,>", "<C-w>5<", { desc = "increase split width" })
vim.keymap.set("n", "<M-.>", "<C-w>5>", { desc = "decrease split width" })
vim.keymap.set("n", "<M-t>", "<C-w>+", { desc = "increase split height" })
vim.keymap.set("n", "<M-s>", "<C-w>-", { desc = "increase split height" })
