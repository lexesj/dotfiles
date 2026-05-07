local function skip_setup(predicate)
	return function()
		return predicate()
	end
end

local function is_remote_devbox()
	return require("stripe_utils").is_remote_devbox()
end

local function is_laptop()
	return not is_remote_devbox()
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
				stripe_autogen = skip_setup(is_laptop),
				-- Use stripe_typescript_native on devbox.
				tsgo = skip_setup(is_remote_devbox),
				vtsls = skip_setup(is_remote_devbox),
			},
		},
	},
}
