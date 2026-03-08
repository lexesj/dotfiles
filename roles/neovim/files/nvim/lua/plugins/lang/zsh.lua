return {
	"neovim/nvim-lspconfig",
	---@module 'lazyvim.plugins.lsp'
	---@type PluginLspOpts
	opts = {
		---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
		setup = {
			bashls = function(_, opts)
				local default_filetypes = require("lspconfig.configs.bashls").default_config.filetypes
				local all_filetypes = vim.list_extend(opts.filetypes or {}, default_filetypes)
				vim.list_extend(all_filetypes, { "zsh" })
				opts.filetypes = all_filetypes
			end,
		},
	},
}
