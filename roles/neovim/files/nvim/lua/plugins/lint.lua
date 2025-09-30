return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "BufReadPre", "InsertLeave" },
	config = function(plugin, opts)
		local lint = require("lint")

		lint.linters_by_ft = opts.linters_by_ft

		vim.api.nvim_create_autocmd(plugin.event, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
