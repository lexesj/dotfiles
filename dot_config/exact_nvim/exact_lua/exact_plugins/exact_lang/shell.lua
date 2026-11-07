return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				shuck = {},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		---@type conform.setupOpts
		opts = {
			formatters = {
				shuck = {
					command = "shuck",
					args = { "format", "--stdin-filename", "$FILENAME", "-" },
					stdin = true,
				},
			},
			formatters_by_ft = {
				bash = { "shuck" },
				sh = { "shuck" },
				zsh = { "shuck" },
			},
		},
	},
}
