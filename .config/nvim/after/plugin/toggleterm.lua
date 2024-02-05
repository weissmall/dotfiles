local term = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal

local lazyGitTerm = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "float",
	float_opts = {
		border = "double",
	},
})

local lazyDockerTerm = Terminal:new({
	cmd = "lazydocker",
	hidden = true,
	direction = "float",
	float_opts = {
		border = "double",
	},
})

local defaultTerminal = Terminal:new({
	-- Always run terminal in `insert` mode
	on_open = function(_)
		vim.cmd("startinsert!")
	end,
})

local function toggleLazyGit()
	lazyGitTerm:toggle()
end

local function toggleLazyDocker()
	lazyDockerTerm:toggle()
end

local function toggleDefaultTerminal()
	defaultTerminal:toggle()
end

vim.keymap.set("n", "<C-t>", toggleDefaultTerminal)
vim.keymap.set("t", "<C-t>", toggleDefaultTerminal)
vim.keymap.set("n", "<leader>gs", toggleLazyGit)
vim.keymap.set("t", "<leader>gs", toggleLazyGit)
vim.keymap.set("n", "<leader>ds", toggleLazyDocker)
vim.keymap.set("t", "<leader>ds", toggleLazyDocker)

term.setup({
	shade_terminals = false,
	shade_filetypes = false,
	persist_size = true,
})
