return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = function()
		local formatter_file_type_map = {
			stylua = { "lua" },
			prettierd = {
				"css",
				"html",
				"javascript",
				"javascriptreact",
				"json",
				"typescript",
				"typescriptreact",
				"yaml",
				"yaml.ansible",
			},
			shfmt = { "bash", "sh", "zsh" },
		}

		local formatters_by_ft = {}
		for formatter, file_types in pairs(formatter_file_type_map) do
			for _, file_type in ipairs(file_types) do
				formatters_by_ft[file_type] = { formatter }
			end
		end

		---@module 'conform'
		---@type conform.setupOpts
		return {
			formatters_by_ft = formatters_by_ft,
			format_on_save = { timeout_ms = 500 },
		}
	end,
}
