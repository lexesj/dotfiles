return {
	"lewis6991/gitsigns.nvim",
	event = "LazyFile",
	opts = {
		current_line_blame = true,
	},
	keys = {
		{ "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", desc = "gitsigns [g]it[h]ub [p]review hunk" },
	},
}
