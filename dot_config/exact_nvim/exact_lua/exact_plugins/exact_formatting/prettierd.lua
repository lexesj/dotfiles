return {
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			-- Rename prettier to prettierd
			for _, formatters in pairs(opts.formatters_by_ft or {}) do
				if type(formatters) == "table" then
					for i, formatter in ipairs(formatters) do
						if formatter == "prettier" then
							formatters[i] = "prettierd"
						end
					end
				end
			end
			opts.formatters = opts.formatters or {}
			if opts.formatters.prettier then
				opts.formatters.prettierd = opts.formatters.prettier
				opts.formatters.prettier = nil
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "prettierd" } },
	},
}
