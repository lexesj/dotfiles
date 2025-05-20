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
				{ "<leader>pf", builtin.find_files, desc = "telescope find files" },
				{ "<leader>pb", builtin.buffers, desc = "telescope buffers" },
				{ "<leader>ps", builtin.live_grep, desc = "telescope live grep" },
				{ "<C-p>", builtin.git_files, desc = "telescope git files" },
				{ "<leader>cd", builtin.diagnostics, desc = "telescope diagnostics" },
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
