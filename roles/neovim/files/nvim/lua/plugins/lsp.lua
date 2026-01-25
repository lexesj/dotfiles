return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		local default_bashls_config = require("lspconfig.configs.bashls").default_config
		opts.servers = opts.servers or {}
		opts.servers.bashls = {
			filetypes = vim.list_extend(default_bashls_config.filetypes or {}, { "zsh" }),
		}

		local disabled_default_keys = {
			{ "gd", false },
			{ "gr", false },
			{ "gI", false },
			{ "gy", false },
		}

		-- stylua: ignore
		local lsp_keymaps = {
			{ "grd", function() Snacks.picker.lsp_definitions() end, desc = "lsp [d]efinitions", },
			{ "gri", function() Snacks.picker.lsp_implementations() end, desc = "lsp [i]mplementations", },
			{ "grr", function() Snacks.picker.lsp_references() end, desc = "lsp [r]eferences", },
		}

		local keys = vim.list_extend(disabled_default_keys, lsp_keymaps)

		-- Apply to ALL servers
		opts.servers["*"] = { keys = keys }
	end,
}
