return {
	"mfussenegger/nvim-dap",
	opts = function()
		local dap = require("dap")
		local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

		for _, ft in ipairs(js_filetypes) do
			dap.configurations[ft] = dap.configurations[ft] or {}
			table.insert(dap.configurations[ft], {
				type = "pwa-node",
				request = "attach",
				name = "Attach to Bun",
				websocketAddress = "ws://127.0.0.1:6499/",
				localRoot = "${workspaceFolder}",
				remoteRoot = "${workspaceFolder}",
			})
		end
	end,
}
