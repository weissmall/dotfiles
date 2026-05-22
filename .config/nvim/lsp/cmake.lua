---@type vim.lsp.Config
return {
  cmd = { "cmake-language-server" },
  filetypes = { "cmake" },
  -- init_options = "build",
  root_markers = { "CmakePresets.json", ".git", "build", "cmake", "CMakeLists.txt" },
  single_file_support = true,
}
