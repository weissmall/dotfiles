-- By default title is off. Needed for detecting window as neovim instance (sworkstyle)

-- Colorscheme
local config = {
  colorscheme = "rose-pine"
};


vim.g.config = config;
if vim.g.vscode then
else
  require("weissmall")
  vim.cmd.colorscheme(vim.g.config.colorscheme)
end

vim.cmd("set title")

vim.lsp.enable("ts_ls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("dockerls")
vim.lsp.enable("terraform-ls")
vim.lsp.enable("gopls")
vim.lsp.enable("eslint")
vim.lsp.enable("nil_ls")
