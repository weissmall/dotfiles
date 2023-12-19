local lsp = require("lsp-zero")

lsp.preset("recommended")

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
	},
	handlers = {
		lsp.default_setup
	}
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

local lspConfig = require("lspconfig")
lspConfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
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
    print("Hello from Rust")
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
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  }
})


lsp.setup()
