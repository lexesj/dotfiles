return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "gotmpl" })
		end,
		init = function()
			-- Detect *.tmpl as gotmpl and record the host language (e.g. "bash"
			-- for foo.sh.tmpl) so the injection query can pick it up.
			vim.filetype.add({
				pattern = {
					[".*%.tmpl"] = function(path, bufnr)
						local without_tmpl = vim.fn.fnamemodify(path, ":r")
						local ext = vim.fn.fnamemodify(without_tmpl, ":e")
						if ext ~= "" then
							local ft = vim.filetype.match({ filename = "file." .. ext }) or ext
							vim.b[bufnr].gotmpl_lang = vim.treesitter.language.get_lang(ft) or ft
						end
						return "gotmpl"
					end,
				},
			})

			-- Register the custom directive before any gotmpl buffer is opened.
			-- It reads the buffer-local gotmpl_lang (set during filetype detection)
			-- and forwards it to the injection query as the host language.
			vim.treesitter.query.add_directive("inject-lang-from-buf!", function(match, pattern, bufnr, pred, metadata)
				local lang = vim.b[bufnr].gotmpl_lang
				if lang then
					metadata["injection.language"] = lang
				end
			end, { force = true })
		end,
	},
}
