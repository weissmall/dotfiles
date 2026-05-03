-- By default title is off. Needed for detecting window as neovim instance (sworkstyle)
if vim.g.vscode then
else
  require("weissmall")
end

vim.cmd("set title")

vim.lsp.enable("ts_ls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("dockerls")
vim.lsp.enable("terraformls")
vim.lsp.enable("gopls")
vim.lsp.enable("eslint")
vim.lsp.enable("nil_ls")
