return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = function()
		local function prettier_or_biome(buffer)
			local file_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(buffer))
			local biome_config = vim.fs.find({ "biome.json", "biome.jsonc" }, {
				upward = true,
				path = file_dir,
				type = "file",
			})

			if #biome_config > 0 then
				return { "biome" }
			end

			return { "prettierd" }
		end

		local prettier_or_biome_filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"json",
			"jsonc",
		}

		local formatters_by_ft = {
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		}
		for _, file_type in ipairs(prettier_or_biome_filetypes) do
			---@diagnostic disable-next-line: assign-type-mismatch
			formatters_by_ft[file_type] = prettier_or_biome
		end

		local formatter_file_type_map = {
			prettierd = { "yaml", "markdown" },
			shfmt = { "bash", "sh", "zsh" },
			stylua = { "lua" },
		}

		for formatter, file_types in pairs(formatter_file_type_map) do
			for _, file_type in ipairs(file_types) do
				formatters_by_ft[file_type] = { formatter }
			end
		end

		---@module 'conform'
		---@type conform.setupOpts
		return {
			formatters_by_ft = formatters_by_ft,
		}
	end,
}
