return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		local default_bashls_config = require("lspconfig.configs.bashls").default_config
		opts.servers = opts.servers or {}
		opts.servers.bashls = {
			filetypes = vim.list_extend(default_bashls_config.filetypes or {}, { "zsh" }),
		}
		-- Apply to ALL servers
		opts.servers["*"] = {
			keys = {
				-- Disable lazyvim default keymaps for LSP
				{ "gd", false },
				{ "gr", false },
				{ "gI", false },
				{ "gy", false },
			},
		}
	end,
}
