---@type vim.lsp.Config
return {
  -- on_attach = function(client)
  --   require("completion").on_attach(client)
  -- end,
  -- capabilities = capabilities,
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
}
