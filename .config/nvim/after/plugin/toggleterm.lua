local term = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal

local defaultTerminal = Terminal:new({
	direction = "float",
	highlights = {
		Normal = {
			guibg = "",
		},
		NormalFloat = {
			link = "Normal",
		},
		FloatBorder = {
			guifg = "",
			guibg = "",
		},
	},
	autochdir = false,
	start_in_insert = false,
	auto_scroll = true,
	winbar = {
		enabled = false,
	},
})

term.setup({
	shade_terminals = false,
	shade_filetypes = false,
	persist_size = true,
})

return {
	terminal = defaultTerminal,
}
