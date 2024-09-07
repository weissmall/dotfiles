local transparent = require("transparent")

transparent.setup({ -- Optional, you don't have to run setup.
	groups = {        -- table: default groups
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLine",
		"CursorLineNr",
		"StatusLine",
		"StatusLineNC",
		"EndOfBuffer",
	},
	extra_groups = {},                                                  -- table: additional groups that should be cleared
	exclude_groups = { "Telescope", "NormalFloat", "Barbar", "Buffer" }, -- table: groups you don't want to clear
})

transparent.clear_prefix("NvimTree")

function SetupColorScheme(colorScheme)
	local color = colorScheme or "rose-pine"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	local tGroups = {
		"NvimTreeNormal",
		"NormalFloat",
		-- require("barbar.utils.highlight"),
	}
	vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, tGroups)
	vim.cmd.TransparentEnable()
	-- vim.cmd.TransparentToggle()
	vim.cmd("hi BufferTabpageFill guibg=transparent")
end

-- SetupColorScheme("tokyonight-night")
SetupColorScheme("catppuccin")

require("catppuccin").setup({
	flavour = "frappe",
})
