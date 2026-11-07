return {
	"leejh903/codex.nvim",
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{ "<leader>ao", "", desc = "+codex", mode = { "n", "v" } },
		{ "<leader>aoo", "<cmd>Codex<cr>", desc = "Toggle Codex" },
		{ "<leader>aof", "<cmd>CodexFocus<cr>", desc = "Focus Codex" },
		{ "<leader>aos", ":CodexSend<cr>", mode = "v", desc = "Send to Codex" },
	},
	opts = {
		split_side = "right",
		split_width_percentage = 0.40,
	},
	config = function(_, opts)
		local codex = require("codex")
		codex.setup()
		require("codex.current_file").setup()
		codex.start()
		require("codex.terminal").setup(opts)
	end,
}
