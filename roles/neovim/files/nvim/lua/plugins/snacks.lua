return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@module 'snacks'
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		picker = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
	},
	keys = function()
		local keymaps = {
			-- LSP.
			{
				"grd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "lsp definitions",
			},
			{
				"grr",
				function()
					Snacks.picker.lsp_references()
				end,
				desc = "lsp references",
			},
			{
				"gri",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "lsp implementations",
			},
			-- Search.
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "[s]earch [d]iagnostics",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "[s]earch [k]eymaps",
			},
			{
				"<leader>sf",
				function()
					Snacks.picker.smart()
				end,
				desc = "[s]earch [f]iles",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "[s]earch [h]elp",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "[s]earch by [g]rep",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.pickers()
				end,
				desc = "[s]earch [s]elect pickers",
			},
			{
				"<leader>sn",
				function()
					Snacks.picker.smart({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "[s]earch [n]eovim config",
			},
			-- Buffers.
			{
				"<leader><space>",
				function()
					Snacks.picker.buffers()
				end,
				desc = "[ ] find existing buffers",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "[b]uffer [d]elete",
			},
		}

		for _, keymap in ipairs(keymaps) do
			keymap.desc = "snacks " .. keymap.desc
		end

		return keymaps
	end,
}
