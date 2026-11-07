return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			-- LazyVim's oxc extra only looks for .oxlintrc.json and oxlint.config.ts. nvim-lspconfig's
			-- default also finds a vite.config.ts with a `lint` block.
			local oxlint = vim.tbl_get(opts, "servers", "oxlint")
			if oxlint then
				oxlint.root_dir = nil
				oxlint.mason = false
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		---@type conform.setupOpts
		opts = {
			formatters = {
				-- Only format with Oxfmt in projects that have an Oxfmt or Vite config.
				oxfmt = { require_cwd = true },
			},
		},
	},
}
