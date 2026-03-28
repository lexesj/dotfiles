return {
	"stevearc/conform.nvim",
	cond = function()
		return require("stripe_utils").is_remote_devbox()
	end,
	opts = {
		formatters_by_ft = {
			bzl = { "buildifier" },
			go = { "stripe_goimports", "gofmt" },
			scala = { "zoolander_format_scala" },
			sql = { "zoolander_format_sql" },
			terraform = { "sc_terraform" },
		},
	},
}
