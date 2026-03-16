return {
	"folke/snacks.nvim",
	---@module 'snacks'
	---@type snacks.Config
	opts = {
		picker = {
			sources = {
				grep = {
					hidden = true,
				},
				files = {
					hidden = true,
				},
				explorer = {
					hidden = true,
				},
			},
			win = {
				input = {
					keys = {
						["<C-c>"] = { "close", mode = { "n" } },
					},
				},
			},
		},
		input = {
			win = {
				keys = {
					n_ctrl_c = { "<C-c>", { "cmp_close", "stopinsert" }, mode = { "i" }, expr = true },
				},
			},
		},
	},
	-- stylua: ignore
	keys = {
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		{ "<leader>bD", function() Snacks.bufdelete() end, desc = "Delete other buffers", },
	},
}
