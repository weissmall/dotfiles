vim.g.barbar_auto_setup = false

local barbar = require("barbar")

barbar.setup({
  animation = false,
  auto_hide = false,
  tabpages = true,
  clickable = true,
})
