local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.load_extension("projects")
telescope.load_extension("notify")
telescope.load_extension("flutter")

local function showProjects()
  require("telescope").extensions.projects.projects({})
end

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fof", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>b", builtin.buffers, {})

vim.keymap.set("n", "<leader>nh", telescope.extensions.notify.notify)

vim.keymap.set("n", "<leader>r", showProjects)

local function flutterCommands()
  return require("telescope").extensions.flutter.commands()
end
vim.keymap.set("n", "<leader>fc", flutterCommands)

--vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
--vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
