-- Resize windows using Alt + hjkl
vim.keymap.set("n", "<M-k>", "<cmd>resize +5<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<M-j>", "<cmd>resize -5<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -5<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +5<cr>", { desc = "Increase Window Width" })

-- Better navigation.
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })

-- File path retrieval.
vim.keymap.set("n", "<leader>fp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify("Copied path to clipboard: " .. path)
end, { desc = "Copy File Path" })
vim.keymap.set("n", "<leader>fr", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify("Copied relative path: " .. path)
end, { desc = "Copy Relative File Path" })

-- Enter normal mode in terminal mode.
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], { desc = "Enter Normal Mode" })
