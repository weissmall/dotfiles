local tree = require("nvim-tree")

vim.keymap.set("n", "<leader>ft", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>ftf", vim.cmd.NvimTreeFocus)
vim.keymap.set("n", "<leader>ftff", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<leader>ftc", vim.cmd.NvimTreeCollapse)

tree.setup({
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
		dotfiles = false,
	},
})
