local notify = require("notify")

vim.notify = notify

local function dismiss()
	notify.dismiss({
		pending = true,
		silent = true,
	})
end

notify.setup({
	timeout = 1,
	background_colour = "#000000",
	level = 1,
	max_width = 30,
	max_height = 100,
	on_open = function() end,
	on_close = function() end,
	fps = 15,
})

vim.keymap.set("n", "<leader>nd", dismiss, { desc = "[N]otification [D]ismiss" })
