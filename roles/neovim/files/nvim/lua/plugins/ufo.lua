return {
	"kevinhwang91/nvim-ufo",
	event = "LazyFile",
	dependencies = { "kevinhwang91/promise-async" },
	init = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	opts = {},
}
