return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = function()
		local formatters_by_ft = { lua = { "stylua" } }

		local prettier_supported_file_types =
			{ "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "html", "json", "yaml" }

		for _, file_type in ipairs(prettier_supported_file_types) do
			formatters_by_ft[file_type] = { "prettierd" }
		end

		return {
			formatters_by_ft = formatters_by_ft,
			format_on_save = { timeout_ms = 500 },
		}
	end,
}
