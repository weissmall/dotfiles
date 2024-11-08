---@module "lazydev"
local lazydev = require("lazydev")

lazydev.setup({
	ft = "lua",
	opts = {
		library = {
			{
				path = "luvit-meta/library",
				words = { "vim%.uv" },
			},
		},
	},
	integrations = {
		cmp = true,
		lspconfig = true,
	},
})
