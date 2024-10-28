local notesDir = "~/zettelkasten"

require("telekasten").setup({
	home = vim.fn.expand(notesDir),
})
