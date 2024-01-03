local lsp = require("lsp-zero")

lsp.preset("recommended")

vim.keymap.set("n", "<leader>lsr", vim.cmd.LspRestart)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
	},
	sources = {
		"nvim_lsp",
		"luasnip",
	},
	handlers = {
		lsp.default_setup,
	},
})

-- local cmp = require("cmp")
-- local cmp_action = lsp.cmp_action()
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
-- cmp.setup({
-- 	mapping = cmp.mapping.preset.insert({
-- 		-- ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- 		-- ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- 		-- ["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 		["<C-Space>"] = cmp.mapping.complete()
-- 	})
-- })
--
local cmp = require("cmp")

cmp.setup({
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
		},
		{
			name = "luasnip",
		},
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<Esc>"] = cmp.mapping.abort(),
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
		["<C-h>"] = cmp.mapping.abort(),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = "insert" }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "insert" }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

local lspConfig = require("lspconfig")
lspConfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = {
					vim.api.nvim_get_runtime_file("", true),
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$HOME/.local/share/nvim")] = true,
				},
			},
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

lspConfig.rust_analyzer.setup({
	on_attach = function(client)
		require("completion").on_attach(client)
	end,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				features = {
					"client",
					"server",
				},
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})
local util = require("lspconfig/util")

lspConfig.gopls.setup({
	cmd = { "gopls", "serve" },
	filetypes = { "go", "go.mod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
})

lspConfig.pyright.setup({
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	python = {},
})

lsp.setup()
