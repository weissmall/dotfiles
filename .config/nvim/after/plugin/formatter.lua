-- local formatter = require("formatter")
--
-- local augroup = vim.api.nvim_create_augroup
-- local autocmd = vim.api.nvim_create_autocmd
-- augroup("__formatter__", { clear = true })
-- autocmd("BufWritePost", {
-- 	group = "__formatter__",
-- 	command = ":FormatWrite",
-- })
--
-- formatter.setup({
-- 	logging = true,
-- 	filetype = {
-- 		-- dart = {
-- 		-- 	require("formatter.filetypes.dart").dartformat,
-- 		-- },
-- 		rust = {
-- 			require("formatter.filetypes.rust").rustfmt,
-- 		},
-- 		lua = {
-- 			require("formatter.filetypes.lua").stylua,
-- 		},
-- 		python = {
-- 			require("formatter.filetypes.python").black,
-- 		},
-- 		cpp = {
-- 			require("formatter.filetypes.cpp").clangformat,
-- 		},
-- 		c = {
-- 			require("formatter.filetypes.c").clangformat,
-- 		},
-- 		["*"] = {
-- 			require("formatter.filetypes.any").remove_trailing_whitespace,
-- 		},
-- 	},
-- })
--
local conform = require("conform")
conform.setup({
	-- [Formatters list](https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters)
	-- :h conform-formatters
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
		dart = { "dart_format" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
