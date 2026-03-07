return {
	"neovim/nvim-lspconfig",
	opts_extend = { "servers.bashls.filetypes" },
	---@module 'lazyvim.plugins.lsp'
	---@type PluginLspOpts
	opts = {
		servers = {
			["*"] = {
				keys = {
					-- disable default LazyVim LSP keymaps.
					{ "gd", false },
					{ "gr", false },
					{ "gI", false },
					{ "gy", false },
					-- Change default Neovim keybinds to use snacks pickers.
					-- stylua: ignore start
					{ "grd", function() Snacks.picker.lsp_definitions() end, desc = "lsp [d]efinitions", },
					{ "gri", function() Snacks.picker.lsp_implementations() end, desc = "lsp [i]mplementations", },
					{ "grr", function() Snacks.picker.lsp_references() end, desc = "lsp [r]eferences", },
					-- stylua: ignore end
				},
			},
		},
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
