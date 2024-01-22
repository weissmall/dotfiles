local dashboard = require("dashboard")
vim.keymap.set("n", "<leader>p", vim.cmd.Dashboard)
dashboard.setup({
	theme = "doom",
	config = {
		header = {}, --your header
		center = {
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Find File",
				desc_hl = "String",
				key = "b",
				keymap = "<C>",
				key_hl = "Number",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(2)",
			},
			{
				icon = " ",
				desc = "Projects manager",
				key = "r",
				keymap = "<C>",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(3)",
			},
			{
				icon = " ",
				desc = "Open dashboard",
				key = "d",
				keymap = "<leader>",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(4)",
			},
		},
		footer = {},
	},
})

-- dashboard.setup({
--   theme = 'hyper',
--   config = {
--     week_header = {
--       enable = true,
--     },
--     shortcut = {
--       { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
--       {
--         icon = ' ',
--         icon_hl = '@variable',
--         desc = 'Files',
--         group = 'Label',
--         action = 'Telescope find_files',
--         key = 'f',
--       },
--       {
--         desc = ' Apps',
--         group = 'DiagnosticHint',
--         action = 'Telescope app',
--         key = 'a',
--       },
--       {
--         desc = ' dotfiles',
--         group = 'Number',
--         action = 'Telescope dotfiles',
--         key = 'd',
--       },
--     },
--   },
-- })
-- dashboard.setup({
--   theme = 'doom',
--   config = {
--     header = {}, --your header
--     center = {
--       {
--         icon = ' ',
--         icon_hl = 'Title',
--         desc = 'Find File           ',
--         desc_hl = 'String',
--         key = 'b',
--         keymap = 'SPC f f',
--         key_hl = 'Number',
--         key_format = ' %s', -- remove default surrounding `[]`
--         action = 'lua print(2)'
--       },
--       {
--         icon = ' ',
--         desc = 'Find Dotfiles',
--         key = 'f',
--         keymap = 'SPC f d',
--         key_format = ' %s', -- remove default surrounding `[]`
--         action = 'lua print(3)'
--       },
--     },
--     footer = {}  --your footer
--   }
-- })
