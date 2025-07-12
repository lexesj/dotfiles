return {
	"mfussenegger/nvim-dap",
	ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	config = function(plugin)
		local dap = require("dap")
		local adapters = { "node", "chrome" }

		for _, adapter in pairs(adapters) do
			dap.adapters["pwa-" .. adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "${port}" },
				},
			}

			dap.adapters[adapter] = function(cb, config)
				if config.type == adapter then
					config.type = "pwa-" .. adapter
				end
				local native_adapter = dap.adapters["pwa-" .. adapter]
				if type(native_adapter) == "function" then
					native_adapter(cb, config)
				else
					cb(native_adapter)
				end
			end
		end

		local vscode = require("dap.ext.vscode")
		vscode.type_to_filetypes["node"] = plugin.ft
		vscode.type_to_filetypes["pwa-node"] = plugin.ft

		for _, language in pairs(plugin.ft) do
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
				{
					type = "chrome",
					request = "attach",
					name = "Attach (browser)",
					port = 9229,
				},
			}
		end
	end,
}
