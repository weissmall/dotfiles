---@type vim.lsp.Config
return {
  filetypes = { "css", "scss", "less" },
  init_options = {
    -- provideFormatter = false,
  },
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },
  },
}
