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
			return {
				{ "grr", builtin.lsp_references, desc = "telescope lsp references" },
				{ "gri", builtin.lsp_implementations, desc = "telescope lsp implementations" },
				{ "gd", builtin.lsp_definitions, desc = "telescope lsp definitions" },
				{ "<leader>sh", builtin.help_tags, desc = "telescope [s]earch [h]elp" },
				{ "<leader>sk", builtin.keymaps, desc = "telescope [s]earch [k]eymaps" },
				{ "<leader>sf", builtin.find_files, desc = "telescope [s]earch [f]iles" },
				{ "<leader>ss", builtin.builtin, desc = "telescope [s]earch [s]elect telescope" },
				{ "<leader>sw", builtin.grep_string, desc = "telescope [s]earch current [w]ord" },
				{ "<leader>sg", builtin.live_grep, desc = "telescope [s]earch by [g]rep" },
				{ "<leader>sd", builtin.diagnostics, desc = "telescope [s]earch [d]iagnostics" },
				{ "<leader>sr", builtin.resume, desc = "telescope [s]earch [r]esume" },
				{ "<leader>s.", builtin.oldfiles, desc = 'telescope [s]earch recent files ("." for repeat)' },
				{ "<leader><leader>", builtin.buffers, desc = "telescope [ ] find existing buffers" },
			}
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
