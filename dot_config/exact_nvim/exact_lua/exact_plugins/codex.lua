return {
	"pittcat/codex.nvim",
	cmd = { "CodexToggle", "CodexSendPath", "CodexSendSelection" },
	keys = {
		{
			"<leader>ao",
			-- stylua: ignore
			function() require("codex").toggle() end,
			desc = "Toggle Codex side-panel",
			mode = { "n", "t" },
		},
		{
			"<leader>aos",
			":'<,'>CodexSendSelection<cr>",
			desc = "Send selected text to Codex",
			mode = { "v" },
		},
		{
			"<leader>ap",
			":CodexSendPath<cr>",
			desc = "Send selected path to Codex",
			mode = { "n" },
		},
	},
	opts = {
		terminal = {
			provider = "auto",
			direction = "vertical",
			size = 0.40,
		},
		terminal_bridge = {
			path_format = "abs",
			path_prefix = "@",
			auto_attach = true,
			selection_mode = "reference",
		},
	},
}
