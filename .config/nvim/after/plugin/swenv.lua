local api = require("swenv.api")
api.auto_venv()
vim.keymap.set("n", "<leader>pyen", api.pick_venv)
vim.keymap.set("n", "<leader>pygen", api.get_current_venv)
