-- Change split size.
vim.keymap.set("n", "<M-,>", "<C-w>5<", { desc = "increase split width" })
vim.keymap.set("n", "<M-.>", "<C-w>5>", { desc = "decrease split width" })
vim.keymap.set("n", "<M-t>", "<C-w>+", { desc = "increase split height" })
vim.keymap.set("n", "<M-s>", "<C-w>-", { desc = "increase split height" })

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
