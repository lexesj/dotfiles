return {
	"mfussenegger/nvim-lint",
	dependencies = {
		{ url = "git@git.corp.stripe.com:stevearc/nvim-stripe-configs" },
	},
	ft = { "ruby" },
	opts = {
		linters_by_ft = {
			ruby = { "pay-server-rubocop" },
		},
	},
}
