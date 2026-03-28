return {
	"mfussenegger/nvim-lint",
	cond = function()
		return require("stripe_utils").is_remote_devbox()
	end,
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
