-- Setting leader key for Space
vim.g.mapleader = " "

-- Setting <leader> + p + v to call `Ex` command in normal mode
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>lsi", vim.cmd.Mason)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

vim.keymap.set("i", "<C-s>", vim.cmd.w)
vim.keymap.set("n", "<C-s>", vim.cmd.w)

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

-- Close
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.keymap.set("n", "<leader>wq", vim.cmd.q)
vim.keymap.set("n", "<leader>qa", vim.cmd.qa)
vim.keymap.set("n", "<leader>wqa", vim.cmd.wqa)
