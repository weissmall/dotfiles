vim.g.barbar_auto_setup = false

local barbar = require("barbar")

barbar.setup({
	animation = true,
	auto_hide = false,
	tabpages = true,
	clickable = true,
	sidebar_filetypes = {
		-- NvimTree = true,
	},
})
