-- Load all snippets from given loaders
vim.tbl_map(
  function (type)
    require("luasnip.loaders.from_" .. type).load();
  end,
  {"vscode", "snipmate", "lua"}
)


require("luasnip.loaders.from_vscode").load({
  paths = {
    "~/.config/nvim/luasnippets/",
  },
})
