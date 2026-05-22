---@type vim.lsp.Config
return {
  -- capabilities = vim.tbl_extend("keep", capabilities, {
  --   offsetEncoding = { "utf-8", "utf-16" },
  --   textDocument = {
  --     completion = {
  --       editsNearCursor = true,
  --     },
  --   },
  -- }),
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
    semanticHighlighting = true,
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  single_file_support = true,
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
  },
}
