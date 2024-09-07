local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.load_extension("projects")
telescope.load_extension("notify")
telescope.load_extension("flutter")

local function showProjects()
  require("telescope").extensions.projects.projects({})
end

local function tlWrapper(fn)
  return function()
    fn({
      layout_strategy = "vertical",
      layout_config = {
        width = 0.8,
      },
    })
  end
end

vim.keymap.set("n", "<leader>ff", tlWrapper(builtin.find_files), {})
-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>fg", tlWrapper(builtin.live_grep), {})
vim.keymap.set("n", "<leader>fof", tlWrapper(builtin.oldfiles), {})
vim.keymap.set("n", "<leader>b", tlWrapper(builtin.buffers), {})

vim.keymap.set("n", "<leader>nh", tlWrapper(telescope.extensions.notify.notify))

vim.keymap.set("n", "<leader>r", tlWrapper(showProjects))

local function flutterCommands()
  return require("telescope").extensions.flutter.commands()
end
vim.keymap.set("n", "<leader>fc", flutterCommands)

--vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
--vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
telescope.setup({
  defaults = {
    layout_config = {
      vertical = {
        width = 0.8,
      },
    },
  },
})
