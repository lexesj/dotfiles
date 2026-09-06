-- Admin app sources live outside admin/assets, where the ESLint library is installed.
-- Find pay-server by ancestor name because it may be nested inside a larger Git checkout,
-- then use admin/assets as ESLint's workspace so those sources can resolve the library.
return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local default_root_dir = vim.lsp.config.eslint.root_dir

			opts.servers.eslint.root_dir = function(bufnr, on_dir)
				local filename = vim.api.nvim_buf_get_name(bufnr)
				local pay_server_root

				for parent in vim.fs.parents(filename) do
					if vim.fs.basename(parent) == "pay-server" then
						pay_server_root = parent
						break
					end
				end

				if pay_server_root and vim.startswith(filename, pay_server_root .. "/admin/") then
					on_dir(pay_server_root .. "/admin/assets")
					return
				end

				if default_root_dir then
					default_root_dir(bufnr, on_dir)
				end
			end
		end,
	},
}
