---@module "snacks"

vim.api.nvim_create_user_command("FormatToggle", function(args)
	if vim.b.disable_autoformat or vim.g.disable_autoformat then
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
		Snacks.notify.info("Auto formatting enabled!")
		return
	end

	if args.bang then
		vim.b.disable_autoformat = true
		Snacks.notify.info("Auto formatting disabled for this buffer!")
	else
		vim.g.disable_autoformat = true
		Snacks.notify.info("Auto formatting globally disabled!")
	end
end, {
	desc = "Re-enable autoformat-on-save",
	bang = true,
})
