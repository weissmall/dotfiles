local formatter = require("formatter")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

formatter.setup({
	logging = true,
	filetype = {
		dart = {
			require("formatter.filetypes.dart").dartformat,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		python = {
			require("formatter.filetypes.python").black,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
