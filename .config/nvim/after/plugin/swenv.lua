local swenv = require("swenv")
local api = require("swenv.api")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		require("swenv.api").auto_venv()
	end,
})

swenv.setup({
	-- venvs_path = vim.fn.expand("~/.cache/pypoetry/virtualenvs"),
	venvs_path = vim.fn.expand("~/poetry-venvs"),
	post_set_venv = vim.cmd.LspRestart,
})

api.auto_venv()
vim.keymap.set("n", "<leader>pyen", api.pick_venv)
vim.keymap.set("n", "<leader>pygen", api.get_current_venv)
