-- require("noice").setup({
-- 	cmdline = {
-- 		view = "cmdline",
-- 	},
-- 	lsp = {
-- 		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
-- 		override = {
-- 			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 			["vim.lsp.util.stylize_markdown"] = true,
-- 			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
-- 		},
-- 	},
-- 	-- you can enable a preset for easier configuration
-- 	presets = {
-- 		bottom_search = true,       -- use a classic bottom cmdline for search
-- 		command_palette = true,     -- position the cmdline and popupmenu together
-- 		long_message_to_split = true, -- long messages will be sent to a split
-- 		inc_rename = true,          -- enables an input dialog for inc-rename.nvim
-- 		lsp_doc_border = true,      -- add a border to hover docs and signature help
-- 	},
-- })

-- local noice = require("noice")
-- noice.setup({
-- 	views = {
-- 		cmdline_popup = {
-- 			border = {
-- 				style = "none",
-- 				padding = { 2, 3 },
-- 			},
-- 			filter_options = {},
-- 			win_options = {
-- 				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
-- 			},
-- 		},
-- 	},
-- 	popupmenu = {
-- 		-- cmp-cmdline has more sources and can be extended
-- 		backend = "cmp", -- backend to use to show regular cmdline completions
-- 	},
-- })
