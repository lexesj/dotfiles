return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui" },
		keys = function()
			-- stylua: ignore
			local keymaps = {
				{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "[d]ebug [b]reakpoint condition", },
				{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "[d]ebug toggle [b]reakpoint", },
				{ "<leader>dc", function() require("dap").continue() end, desc = "[d]ebug run/[c]ontinue", },
				{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "[d]ebug run to [C]ursor", },
				{ "<leader>dg", function() require("dap").goto_() end, desc = "[d]ebug [g]o to line (no execute)", },
				{ "<leader>di", function() require("dap").step_into() end, desc = "[d]ebug step [i]nto", },
				{ "<leader>dj", function() require("dap").down() end, desc = "[d]ebug down", },
				{ "<leader>dk", function() require("dap").up() end, desc = "debug up", },
				{ "<leader>dl", function() require("dap").run_last() end, desc = "[d]ebug run [l]ast", },
				{ "<leader>do", function() require("dap").step_out() end, desc = "[d]ebug step [o]ut", },
				{ "<leader>dO", function() require("dap").step_over() end, desc = "[d]ebug step [O]ver", },
				{ "<leader>dP", function() require("dap").pause() end, desc = "[d]ebug [P]ause", },
				{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "[d]ebug toggle [r]epl", },
				{ "<leader>ds", function() require("dap").session() end, desc = "[d]ebug session", },
				{ "<leader>dt", function() require("dap").terminate() end, desc = "[d]ebug [t]erminate", },
				{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "[d]ebug [w]idgets", },
			}

			for _, keymap in ipairs(keymaps) do
				keymap.desc = "dap " .. keymap.desc
			end

			return keymaps
		end,
		config = function()
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
		-- stylua: ignore
		keys = {
			{ "<leader>du", function() require("dapui").toggle({ }) end, desc = "dap [d]ebug [u]i" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "dap [d]ebug [e]val", mode = {"n", "v"} },
		},
		opts = {},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
}
