local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.load_extension("projects")
telescope.load_extension("notify")

local function showProjects()
  require("telescope").extensions.projects.projects({})
end

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fof", builtin.oldfiles, {})
vim.keymap.set("n", "<C-b>", builtin.buffers, {})

vim.keymap.set("n", "<leader>nh", telescope.extensions.notify.notify)

vim.keymap.set("n", "<C-r>", showProjects)

--vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
--vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
