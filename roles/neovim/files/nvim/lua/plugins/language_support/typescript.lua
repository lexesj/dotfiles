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
					request = "launch",
					name = "Debug test file (Jest)",
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
					program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
					args = { "--runInBand", "--testPathPattern", "${fileBasename}" },
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
				},
				{
					type = "node",
					request = "launch",
					name = "Debug test file (Mocha)",
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
					program = "${workspaceFolder}/node_modules/mocha/bin/mocha.js",
					args = { "--grep", "${fileBasename}" },
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
				},
				{
					type = "node",
					request = "launch",
					name = "Debug test file (Vitest)",
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
					program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
					args = { "run", "${relativeFile}" },
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
				},
				{
					type = "node",
					request = "attach",
					name = "Attach to debugger",
					protocol = "inspector",
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
					cwd = "${workspaceFolder}",
				},
				{
					type = "chrome",
					request = "attach",
					name = "Attach to debugger (browser)",
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
					port = 9229,
				},
			}
		end
	end,
}
