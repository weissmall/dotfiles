--- @module "bufferline"
local bufferline = require("bufferline")

bufferline.setup({
	options = {
		style_preset = {
			bufferline.style_preset.minimal,
			bufferline.style_preset.no_bold,
			bufferline.style_preset.no_italic,
		},
		separator_style = "thin",
		themable = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		},
	},
})