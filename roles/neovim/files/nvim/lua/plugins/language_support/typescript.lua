return {
	"mfussenegger/nvim-dap",
	ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	config = function(plugin)
		local dap = require("dap")
		local vscode = require("dap.ext.vscode")
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

			vscode.type_to_filetypes[adapter] = plugin.ft
			vscode.type_to_filetypes["pwa-" .. adapter] = plugin.ft
		end

		for _, language in pairs(plugin.ft) do
			dap.configurations[language] = {
				{
					type = "node",
					request = "launch",
					name = "Debug file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "node",
					request = "attach",
					name = "Debug test file (Jest)",
					program = "${workspaceRoot}/node_modules/jest/bin/jest.js",
					args = { "--verbose", "-i", "--no-cache", "--testPathPattern", "${fileBasename}" },
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					cwd = "${workspaceFolder}",
				},
				{
					type = "node",
					request = "launch",
					name = "Debug test file (Vitest)",
					autoAttachChildProcesses = true,
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
					program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
					args = { "run", "${relativeFile}" },
					smartStep = true,
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
				},
				{
					type = "node",
					request = "attach",
					name = "Attach to debugger",
					protocol = "inspector",
					cwd = "${workspaceFolder}",
				},
				{
					type = "chrome",
					request = "attach",
					name = "Attach to debugger (browser)",
					port = 9229,
				},
			}
		end
	end,
}
