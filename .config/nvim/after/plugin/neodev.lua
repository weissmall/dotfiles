local neodev = require("neodev")

neodev.setup({
	library = {
		plugins = {
			"neotest",
			"nvim-dap",
			"nvim-dap-ui",
			"toggleterm",
			"neotest-dart",
			"neotest-vitest",
			"markdown-preview",
		},
		types = true,
	},
})
