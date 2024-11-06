local dap = require("dap")
local dapui = require("dapui")

local dapVscode = require("dap.ext.vscode")
dapVscode.json_decode = require("json5").parse

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- require("dap-vscode-js").setup({
-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
-- adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
-- })

dap.adapters.dart = {
	type = "executable",
	command = "dart",
	args = { "debug_adapter" },
}

dap.adapters.flutter = {
	type = "executable",
	command = "flutter",
	args = { "debug_adapter" },
}

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb",
	name = "lldb",
}

dap.adapters["lldb-vscode"] = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb-vscode",
}

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		-- 💀 Make sure to update this path to point to your installation
		args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
	},
}

dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch dart",
		dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
		flutterSdkPath = "/opt/flutter/bin/flutter",            -- ensure this is correct
		program = "${workspaceFolder}/lib/main.dart",           -- ensure this is correct
		cwd = "${workspaceFolder}",
	},
	{
		type = "flutter",
		request = "launch",
		name = "Launch flutter",
		dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
		flutterSdkPath = "/opt/flutter/bin/flutter",            -- ensure this is correct
		program = "${workspaceFolder}/lib/main.dart",           -- ensure this is correct
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb-vscode",
		request = "launch",
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}

local exts = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	-- using pwa-chrome
	"vue",
	"svelte",
}

for _, ext in ipairs(exts) do
	dap.configurations[ext] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node)",
			cwd = vim.fn.getcwd(),
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node with ts-node)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "--loader", "ts-node/esm" },
			runtimeExecutable = "node",
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			attachSimplePort = 9229,
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with jest)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
			runtimeExecutable = "node",
			args = { "${file}", "--coverage", "false" },
			rootPath = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with vitest)",
			cwd = vim.fn.getcwd(),
			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
			args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
			autoAttachChildProcesses = true,
			smartStep = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			attachSimplePort = 9229,
		},
		{
			type = "pwa-chrome",
			request = "attach",
			name = "Attach Program (pwa-chrome = { port: 9222 })",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			port = 9222,
			webRoot = "${workspaceFolder}",
		},
		{
			type = "node2",
			request = "attach",
			name = "Attach Program (Node2)",
			processId = require("dap.utils").pick_process,
		},
		{
			type = "node2",
			request = "attach",
			name = "Attach Program (Node2 with ts-node)",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			port = 9229,
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach Program (pwa-node)",
			cwd = vim.fn.getcwd(),
			processId = require("dap.utils").pick_process,
			skipFiles = { "<node_internals>/**" },
		},
	}
end

local function launchJson()
	dapVscode.load_launchjs(".nvimproj/launch.json")
end

vim.keymap.set("n", "<leader>do", dapui.open)
vim.keymap.set("n", "<leader>dc", dapui.close)
vim.keymap.set("n", "<leader>dlj", launchJson)
vim.keymap.set("n", "<leader>dtl", "<CMD>DapToggleRepl<CR>")

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
