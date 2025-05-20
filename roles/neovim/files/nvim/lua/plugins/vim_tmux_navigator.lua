return {
	"christoomey/vim-tmux-navigator",
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "go to left window" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "go to upper window" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "go to lower window" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "go to right window" },
	},
}
