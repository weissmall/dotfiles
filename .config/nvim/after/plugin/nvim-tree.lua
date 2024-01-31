local tree = require("nvim-tree")

vim.keymap.set("n", "<leader>ft", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>ftf", vim.cmd.NvimTreeFocus)
vim.keymap.set("n", "<leader>ftff", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<leader>ftc", vim.cmd.NvimTreeCollapse)

tree.setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		git_ignored = false,
		dotfiles = false,
		git_clean = false,
		no_buffer = false,
		no_bookmark = false,
	},
})
