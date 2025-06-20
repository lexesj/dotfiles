---@alias LspConfigOpts { servers: table<string, vim.lsp.Config>, diagnostic: vim.diagnostic.Opts }

return {
	{
		"neovim/nvim-lspconfig",
		version = "*",
		event = "LazyFile",
		dependencies = {
			{ "mason-org/mason.nvim", cmd = "Mason", opts = {} },
			{ "mason-org/mason-lspconfig.nvim", opts = {} },
		},
		opts = function()
			local default_bashls_config = require("lspconfig.configs.bashls").default_config
			---@type LspConfigOpts
			return {
				servers = {
					bashls = {
						filetypes = vim.list_extend(default_bashls_config.filetypes, { "zsh" }),
					},
				},
				diagnostic = {
					virtual_lines = { current_line = true },
				},
			}
		end,
		---@param opts LspConfigOpts
		config = function(_, opts)
			vim.diagnostic.config(opts.diagnostic)
			for server, config in pairs(opts.servers) do
				vim.lsp.config(server, config)
			end
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
	{ "mfussenegger/nvim-ansible", ft = "yaml" },
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			completion = {
				documentation = { auto_show = true },
				ghost_text = { enabled = true },
			},
			signature = { enabled = true },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
		},
		opts_extend = { "sources.default" },
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
}
