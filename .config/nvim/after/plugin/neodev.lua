local neodev = require("neodev")

neodev.setup({
	library = {
		plugins = {
			"lazy",
			"neotest",
			"nvim-dap",
			"nvim-dap-ui",
			"toggleterm",
			"neotest-dart",
			"neotest-vitest",
			"markdown-preview",
			"flutter-tools",
			"nvim-tree",
		},
		types = true,
	},
})
