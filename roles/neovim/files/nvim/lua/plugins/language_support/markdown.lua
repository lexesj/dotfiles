return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				markdown = { "markdownlint-cli2" },
			},
		},
	},
}
