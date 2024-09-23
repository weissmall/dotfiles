local bookmarks = require("bookmarks")

local function on_attach(bufnr)
	vim.keymap.set("n", "mm", bookmarks.bookmark_toggle)
	vim.keymap.set("n", "mc", bookmarks.bookmark_clean)
	vim.keymap.set("n", "ml", bookmarks.bookmark_list)
end

bookmarks.setup({
	-- Save file
	save_file = vim.fn.expand("$HOME/.nvim-bookmarks"),
	keywords = {
		["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
		["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
		["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
		["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
	},
	on_attach = on_attach,
})
