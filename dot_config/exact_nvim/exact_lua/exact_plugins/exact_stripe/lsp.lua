local function should_skip_setup()
	local skip_setup = require("stripe_utils").is_remote_devbox()
	return skip_setup
end

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
				stripe_autogen = should_skip_setup,
				tsgo = should_skip_setup,
				vtsls = should_skip_setup,
			},
		},
	},
}
