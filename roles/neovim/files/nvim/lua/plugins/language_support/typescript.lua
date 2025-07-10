return {
	"mfussenegger/nvim-dap",
	ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	config = function(plugin)
		local dap = require("dap")

		local vscode = require("dap.ext.vscode")
		vscode.type_to_filetypes["node"] = plugin.ft
		vscode.type_to_filetypes["pwa-node"] = plugin.ft

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "js-debug-adapter",
				args = { "${port}" },
			},
		}

		for _, language in ipairs(plugin.ft) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					protocol = "inspector",
					cwd = "${workspaceFolder}",
				},
			}
		end
	end,
}
