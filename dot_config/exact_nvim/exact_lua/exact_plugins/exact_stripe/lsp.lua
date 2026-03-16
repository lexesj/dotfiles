return {
	{
		"virtual_js_scripts",
		virtual = true,
		dependencies = {
			"stevearc/nvim-stripe-configs",
		},
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		config = function()
			require("stripe_configs.javascript").auto_build_js_cli()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ url = "git@git.corp.stripe.com:stevearc/nvim-stripe-configs" },
		},
		---@module 'lazyvim.plugins.lsp'
		---@type PluginLspOpts
		opts = {
			servers = {
				eslint = { mason = false },
				ruff = { mason = false },
				stripe_autogen = {},
				stripe_checkmate = {},
				stripe_gopls = {},
				stripe_scip = {},
				stripe_sorbet = {},
				stripe_starpls = {},
				stripe_typescript_native = {},
			},
			setup = {
				-- disable vtsls in favour of stripe_typescript_native.
				vtsls = function()
					local skip_setup = require("stripe_utils").is_remote_devbox()
					return skip_setup
				end,
			},
		},
	},
}
