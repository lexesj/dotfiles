return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {},
			},
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {},
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			keymap = { preset = "default" },
		},
		opts_extend = { "sources.default" },
	},
}
