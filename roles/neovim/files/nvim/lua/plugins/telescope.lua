return {
	{
		"nvim-telescope/telescope.nvim",
		opts = {},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("ui-select")
		end,
		keys = function()
			---@param module string
			local function lazy_builtin(module)
				return function(...)
					return require("telescope.builtin")[module](...)
				end
			end

			local keymaps = {
				{ "grr", lazy_builtin("lsp_references"), desc = "lsp references" },
				{ "gri", lazy_builtin("lsp_implementations"), desc = "lsp implementations" },
				{ "gd", lazy_builtin("lsp_definitions"), desc = "lsp definitions" },
				{ "<leader>sh", lazy_builtin("help_tags"), desc = "[s]earch [h]elp" },
				{ "<leader>sk", lazy_builtin("keymaps"), desc = "[s]earch [k]eymaps" },
				{ "<leader>sf", lazy_builtin("find_files"), desc = "[s]earch [f]iles" },
				{ "<leader>sp", lazy_builtin("git_files"), desc = "[s]earch [p]roject files" },
				{ "<leader>ss", lazy_builtin("builtin"), desc = "[s]earch [s]elect telescope" },
				{ "<leader>sw", lazy_builtin("grep_string"), desc = "[s]earch current [w]ord" },
				{ "<leader>sg", lazy_builtin("live_grep"), desc = "[s]earch by [g]rep" },
				{ "<leader>sd", lazy_builtin("diagnostics"), desc = "[s]earch [d]iagnostics" },
				{ "<leader>sr", lazy_builtin("resume"), desc = "[s]earch [r]esume" },
				{ "<leader>s.", lazy_builtin("oldfiles"), desc = '[s]earch recent files ("." for repeat)' },
				{ "<leader><leader>", lazy_builtin("buffers"), desc = "[ ] find existing buffers" },
				{
					"<leader>sn",
					function()
						lazy_builtin("find_files")({ cwd = vim.fn.stdpath("config") })
					end,
					desc = "[s]earch [n]eovim files",
				},
			}

			for _, keymap in ipairs(keymaps) do
				keymap.desc = "telescope " .. keymap.desc
			end

			return keymaps
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		event = "User UiSelect",
	},
}
