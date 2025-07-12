return {
	"mfussenegger/nvim-dap",
	ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	config = function(plugin)
		local dap = require("dap")

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "js-debug-adapter",
				args = { "${port}" },
			},
		}

		dap.adapters["node"] = function(cb, config)
			if config.type == "node" then
				config.type = "pwa-node"
			end
			local native_adapter = dap.adapters["pwa-node"]
			if type(native_adapter) == "function" then
				native_adapter(cb, config)
			else
				cb(native_adapter)
			end
		end

		local vscode = require("dap.ext.vscode")
		vscode.type_to_filetypes["node"] = plugin.ft
		vscode.type_to_filetypes["pwa-node"] = plugin.ft

		for _, language in ipairs(plugin.ft) do
			dap.configurations[language] = {
				{
					type = "node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "node",
					request = "attach",
					name = "Attach",
					protocol = "inspector",
					cwd = "${workspaceFolder}",
				},
			}
		end
	end,
}
