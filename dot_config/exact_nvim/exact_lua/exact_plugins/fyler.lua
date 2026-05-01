return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	lazy = false,
	---@module 'fyler.config'
	---@type FylerSetup
	opts = {
		integrations = {
			winpick = "snacks",
		},
		views = {
			---@diagnostic disable-next-line: missing-fields
			finder = {
				mappings = {
					["-"] = "GotoNode",
				},
			},
		},
	},
	keys = {
		{ "-", "<cmd>Fyler<cr>", desc = "Open Fyler view" },
	},
}
