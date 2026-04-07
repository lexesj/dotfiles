return {
	"kkrampis/codex.nvim",
	cmd = { "Codex", "CodexToggle" },
	keys = {
		{
			"<leader>ao",
			-- stylua: ignore
			function() require("codex").toggle() end,
			desc = "Toggle Codex popup or side-panel",
			mode = { "n", "t" },
		},
	},
	opts = {},
}
