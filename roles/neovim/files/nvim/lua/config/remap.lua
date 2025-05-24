vim.g.mapleader = " "

vim.keymap.set("n", "<leader>l", vim.cmd.Lazy, { desc = "open lazy" })

-- Change split size.
vim.keymap.set("n", "<M-,>", "<C-w>5<", { desc = "increase split width" })
vim.keymap.set("n", "<M-.>", "<C-w>5>", { desc = "decrease split width" })
vim.keymap.set("n", "<M-t>", "<C-w>+", { desc = "increase split height" })
vim.keymap.set("n", "<M-s>", "<C-w>-", { desc = "increase split height" })

-- Better movement with text overflow.
local function vertial_move(key)
	return function()
		local count = vim.v.count
		if count == 0 then
			return "g" .. key
		end
		return key
	end
end

vim.keymap.set("n", "j", vertial_move("j"), { expr = true, desc = "move vertically down" })
vim.keymap.set("n", "k", vertial_move("k"), { expr = true, desc = "move vertically up" })
