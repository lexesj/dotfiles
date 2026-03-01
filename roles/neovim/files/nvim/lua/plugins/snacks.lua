return {
	"folke/snacks.nvim",
	---@module 'snacks'
	---@type snacks.Config
	opts = {
		picker = {
			sources = {
				grep = {
					hidden = true,
				},
				files = {
					hidden = true,
				},
				explorer = {
					hidden = true,
				},
			},
			win = {
				input = {
					keys = {
						["<C-c>"] = { "close", mode = { "n" } },
					},
				},
			},
		},
	},
}
