local original_vim_ui = vim.ui

local proxy_vim_ui = setmetatable({}, {
	__index = function(_, key)
		if key == "select" then
			vim.api.nvim_exec_autocmds("User", { pattern = "UiSelect" })
		end
		return original_vim_ui[key]
	end,
	__newindex = function(_, key, value)
		original_vim_ui[key] = value
	end,
})

vim.ui = proxy_vim_ui
