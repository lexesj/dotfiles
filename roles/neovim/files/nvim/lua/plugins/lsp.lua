return {
	"neovim/nvim-lspconfig",
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
	},
}
