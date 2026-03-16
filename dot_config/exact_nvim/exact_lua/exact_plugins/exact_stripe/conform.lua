return {
	"stevearc/conform.nvim",
	dependencies = {
		{ url = "git@git.corp.stripe.com:stevearc/nvim-stripe-configs" },
	},
	opts = {
		formatters_by_ft = {
			bzl = { "buildifier" },
			go = { "stripe_goimports", "gofmt" },
			graphql = { "prettierd" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			scala = { "zoolander_format_scala" },
			sql = { "zoolander_format_sql" },
			terraform = { "sc_terraform" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
		},
	},
}
