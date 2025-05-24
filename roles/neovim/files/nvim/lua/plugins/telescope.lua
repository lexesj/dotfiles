return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function()
			return {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			}
		end,
		keys = function()
			local builtin = require("telescope.builtin")
			local keymaps = {
				{ "grr", builtin.lsp_references, desc = "lsp references" },
				{ "gri", builtin.lsp_implementations, desc = "lsp implementations" },
				{ "gd", builtin.lsp_definitions, desc = "lsp definitions" },
				{ "<leader>sh", builtin.help_tags, desc = "[s]earch [h]elp" },
				{ "<leader>sk", builtin.keymaps, desc = "[s]earch [k]eymaps" },
				{ "<leader>sf", builtin.find_files, desc = "[s]earch [f]iles" },
				{ "<leader>ss", builtin.builtin, desc = "[s]earch [s]elect telescope" },
				{ "<leader>sw", builtin.grep_string, desc = "[s]earch current [w]ord" },
				{ "<leader>sg", builtin.live_grep, desc = "[s]earch by [g]rep" },
				{ "<leader>sd", builtin.diagnostics, desc = "[s]earch [d]iagnostics" },
				{ "<leader>sr", builtin.resume, desc = "[s]earch [r]esume" },
				{ "<leader>s.", builtin.oldfiles, desc = '[s]earch recent files ("." for repeat)' },
				{ "<leader><leader>", builtin.buffers, desc = "[ ] find existing buffers" },
				{
					"<leader>sn",
					function()
						builtin.find_files({ cwd = vim.fn.stdpath("config") })
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
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
