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
				"markdown",
			},
			shfmt = { "bash", "sh", "zsh" },
		}

		local formatters_by_ft = {}
		for formatter, file_types in pairs(formatter_file_type_map) do
			for _, file_type in ipairs(file_types) do
				formatters_by_ft[file_type] = { formatter }
			end
		end

		---@param buffer integer Buffer to format.
		local function format_on_save(buffer)
			if vim.g.disable_autoformat or vim.b[buffer].disable_autoformat then
				return
			end
			return {
				lsp_format = "fallback",
				timeout_ms = 3000,
			}
		end

		---@module 'conform'
		---@type conform.setupOpts
		return {
			formatters_by_ft = formatters_by_ft,
			format_on_save = format_on_save,
		}
	end,
}
