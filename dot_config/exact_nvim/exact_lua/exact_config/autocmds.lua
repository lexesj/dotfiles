vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		if event.data.actions.type == "move" then
			Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
		end
	end,
})

-- Disable spell autocmd
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Chezmoi apply in the chezmoi directory.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
	callback = function(ev)
		local bufnr = ev.buf
		local edit_watch = function()
			require("chezmoi.commands.__edit").watch(bufnr)
		end
		vim.schedule(edit_watch)
	end,
})

-- Ensure diff mode has wrapping enabled.
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "diff",
	callback = function()
		if vim.v.option_new == "1" then
			vim.opt_local.wrap = true
		end
	end,
})

vim.api.nvim_create_user_command("LspLogClear", function()
	local log_path = vim.lsp.log.get_filename()
	local size_mb = (vim.uv.fs_stat(log_path) or {}).size or 0
	size_mb = math.floor(size_mb / 1024 / 1024 * 10) / 10
	local fd = io.open(log_path, "w")
	if fd then
		fd:close()
		vim.notify(string.format("LSP log cleared (%.1f MB): %s", size_mb, log_path))
	else
		vim.notify("Failed to clear LSP log: " .. log_path, vim.log.levels.ERROR)
	end
end, { desc = "Clears the Neovim LSP log file" })
