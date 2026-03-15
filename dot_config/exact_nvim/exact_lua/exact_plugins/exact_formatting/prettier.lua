return {
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			for _, formatters in pairs(opts.formatters_by_ft or {}) do
				if type(formatters) == "table" then
					for i, f in ipairs(formatters) do
						if f == "prettier" then
							formatters[i] = "prettierd"
						end
					end
				end
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "prettierd" } },
	},
}
