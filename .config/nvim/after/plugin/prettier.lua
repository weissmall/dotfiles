local prettier = require("prettier")
prettier.setup({
	-- ["lsp-zero"] = {
	-- 	condition = function()
	-- 		return prettier.config_exists({
	-- 			check_package_json = true,
	-- 		})
	-- 	end,
	-- 	runtime_condition = function(_)
	-- 		return true
	-- 	end,
	-- 	timeout = 5000,
	-- },
	bin = "prettierd",
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})
