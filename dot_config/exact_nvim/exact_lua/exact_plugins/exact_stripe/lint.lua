return {
	"mfussenegger/nvim-lint",
	cond = function()
		return require("stripe_utils").is_remote_devbox()
	end,
	ft = { "ruby" },
	opts = {
		linters_by_ft = {
			ruby = { "pay-server-rubocop" },
		},
	},
}
