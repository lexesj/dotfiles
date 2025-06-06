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
		local most_used_keymaps = {
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "[ ] smart find files",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "[/] search by grep",
			},
			{
				"<leader>,",
				function()
					Snacks.picker.buffers()
				end,
				desc = "[,] search buffers",
			},
			{
				"<leader>:",
				function()
					Snacks.picker.command_history()
				end,
				desc = "[:] search command history",
			},
			{
				"<leader>n",
				function()
					Snacks.picker.notifications()
				end,
				desc = "search [n]otification history",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "file [e]explorer",
			},
		}

		local find_file_keymaps = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "[f]ind [f]iles",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.files()
				end,
				desc = "[f]ind files in [b]uffers",
			},
			{
				"<leader>fn",
				function()
					Snacks.picker.smart({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "[f]ind in [n]eovim config",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "[f]ind [p]rojects",
			},
		}

		local search_keymaps = {
			{
				"<leader>sc",
				function()
					Snacks.picker.command_history()
				end,
				desc = "[s]earch [c]ommand history",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "[s]earch [d]iagnostics",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "[s]earch [h]elp",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "[s]earch [k]eymaps",
			},
			{
				"<leader>sp",
				function()
					Snacks.picker.pickers()
				end,
				desc = "[s]earch [p]ickers",
			},
			{
				"<leader>sq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "[s]earch [q]uickfix list",
			},
			{
				'<leader>s"',
				function()
					Snacks.picker.registers()
				end,
				desc = "[s]earch [r]egisters",
			},
			-- Grep.
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "grep [s]each open [B]uffers",
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "[s]earch buffer lines",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "[s]earch by [g]rep",
			},
		}

		local lsp_keymaps = {
			{
				"grd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "lsp [d]efinitions",
			},
			{
				"gri",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "lsp [i]mplementations",
			},
			{
				"grr",
				function()
					Snacks.picker.lsp_references()
				end,
				desc = "lsp [r]eferences",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "[s]earch lsp [s]ymbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "[s]earch workspace [S]ymbols",
			},
		}

		local git_keymaps = {
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "open lazy[g]it",
			},
		}

		local buffer_keymaps = {
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "[b]uffer [d]elete",
			},
			{
				"<leader>bD",
				function()
					Snacks.bufdelete.all()
				end,
				desc = "[b]uffer [D]elete all",
			},
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "[.] toggle scratch buffer",
			},
		}

		local terminal_keymaps = {
			{
				"<c-_>",
				function()
					Snacks.terminal()
				end,
				desc = "[<c-_>] toggle terminal",
			},
		}

		local keymaps = {}

		vim.list_extend(keymaps, most_used_keymaps)
		vim.list_extend(keymaps, find_file_keymaps)
		vim.list_extend(keymaps, search_keymaps)
		vim.list_extend(keymaps, lsp_keymaps)
		vim.list_extend(keymaps, git_keymaps)
		vim.list_extend(keymaps, buffer_keymaps)
		vim.list_extend(keymaps, terminal_keymaps)

		for _, keymap in ipairs(keymaps) do
			keymap.desc = "snacks " .. keymap.desc
		end

		return keymaps
	end,
	init = function()
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("snacks-toggles", { clear = true }),
			pattern = "VeryLazy",
			callback = function()
				Snacks.toggle
					.new({
						id = "format_on_save",
						name = "[f]ormat on save (global)",
						get = function()
							return not vim.g.disable_autoformat
						end,
						set = function(state)
							vim.g.disable_autoformat = not state
						end,
					})
					:map("<leader>tf")

				Snacks.toggle
					.new({
						id = "format_on_save_buffer",
						name = "[f]ormat on save (buffer)",
						get = function()
							return not vim.b.disable_autoformat
						end,
						set = function(state)
							vim.b.disable_autoformat = not state
						end,
					})
					:map("<leader>tF")

				Snacks.toggle.option("spell", { name = "[s]pelling" }):map("<leader>us")
			end,
		})
	end,
}
