return {
	"leejh903/codex.nvim",
	commit = "ea699ace144d6db24ad0fbb1973fd8bb398665f5",
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{
			"<leader>ao",
			"<cmd>Codex<cr>",
			desc = "Toggle Codex",
			mode = { "n", "t" },
		},
		{
			"<leader>aos",
			":'<,'>CodexSend<cr>",
			desc = "Reference selection in Codex",
			mode = { "v" },
		},
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
