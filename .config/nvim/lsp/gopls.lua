---@type vim.lsp.Config
return {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  cmd = { "gopls" },
  filetypes = { "go", "go.mod" },
  root_markers = {
    "go.work",
    "go.mod",
    ".git",
  },
}
