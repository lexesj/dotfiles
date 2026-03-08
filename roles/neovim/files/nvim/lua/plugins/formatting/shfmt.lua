return {
	"stevearc/conform.nvim",
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			bash = { "shfmt" },
			sh = { "shfmt" },
			zsh = { "shfmt" },
		},
	},
}
