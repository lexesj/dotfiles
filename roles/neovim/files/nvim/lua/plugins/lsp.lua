---@class LspConfigOpts
---@field servers table<string, vim.lsp.Config>
---@field diagnostic vim.diagnostic.Opts

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
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
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "mfussenegger/nvim-ansible" },
	{
		"saghen/blink.cmp",
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
		},
		opts_extend = { "sources.default" },
	},
}
