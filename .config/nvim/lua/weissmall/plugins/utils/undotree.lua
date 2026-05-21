---@module 'lazy'
---@type LazySpec
return {
  "mbbill/undotree",
  lazy = true,
  ---@type LazyKeysSpec[]
  keys = {
    {
      "<leader>ut",
      "<cmd>UndotreeToggle<cr>",
      desc = "[U]ndotree [T]oggle",
    },
  }
}
