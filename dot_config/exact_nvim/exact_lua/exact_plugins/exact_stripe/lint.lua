return {
	"mfussenegger/nvim-lint",
	dependencies = {
		{ url = "git@git.corp.stripe.com:stevearc/nvim-stripe-configs" },
	},
	ft = { "ruby" },
	opts = function(_, opts)
		if require("stripe_utils").is_remote_devbox() then
			local linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft = vim.tbl_deep_extend("force", linters_by_ft, {
				ruby = { "pay-server-rubocop" },
			})
		end
	end,
}
