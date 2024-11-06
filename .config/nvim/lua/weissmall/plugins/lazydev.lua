local lazydev = {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
}

local blink = { -- optional blink completion source for require statements and module annotations
	"saghen/blink.cmp",
	opts = {
		sources = {
			-- add lazydev to your completion providers
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
			},
			providers = {
				-- dont show LuaLS require statements when lazydev has items
				lsp = { fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
			},
		},
	},
}

return {
	lazydev = lazydev,
	blink = blink,
}
