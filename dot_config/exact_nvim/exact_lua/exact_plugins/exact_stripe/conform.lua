return {
	"stevearc/conform.nvim",
	dependencies = {
		{ url = "git@git.corp.stripe.com:stevearc/nvim-stripe-configs" },
	},
	opts = function(_, opts)
		if require("stripe_utils").is_remote_devbox() then
			formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft = vim.tbl_deep_extend("force", formatters_by_ft, {
				bzl = { "buildifier" },
				go = { "stripe_goimports", "gofmt" },
				scala = { "zoolander_format_scala" },
				sql = { "zoolander_format_sql" },
				terraform = { "sc_terraform" },
			})
		end
	end,
}
