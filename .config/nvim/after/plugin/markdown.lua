-- vim.keymap.set("n", "<leader>omp", "<Cmd>MarkdownPreview<CR>", { desc = "[Open] [M]arkdown [P]review" })
require("render-markdown").setup({
	file_types = {
		"markdown",
		"telekasten",
	},
})

vim.treesitter.language.register("markdown", "telekasten")
