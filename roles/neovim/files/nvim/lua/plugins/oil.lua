return {
	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "open parent directory" },
		},
	},
	{
		"benomahony/oil-git.nvim",
		opts = {},
	},
}
