return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"ansible-language-server",
				"ansible-lint",
				"bash-language-server",
				"biome",
				"eslint-lsp",
				"js-debug-adapter",
				"json-lsp",
				"lua-language-server",
				"markdownlint-cli2",
				"prettierd",
				"pyright",
				"ruff",
				"stylua",
				"typescript-language-server",
			},
		},
	},
}
