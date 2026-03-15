return {
	"stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
		},
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
}
