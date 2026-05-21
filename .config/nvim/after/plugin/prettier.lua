local prettier = require("prettier")
prettier.setup({
  bin = "prettierd",
  cli_options = {
    config_precedence = "prefer-file",
  },
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})
