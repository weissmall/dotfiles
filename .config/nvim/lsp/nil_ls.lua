---@type vim.lsp.Config
return {
  cmd = { "nls" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
}
