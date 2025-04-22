---@module 'blink'
---@type blink.cmp.KeymapConfig
local keymap = {
  -- preset = "super-tab",
  ["<C-k>"] = { "select_prev", "fallback" },
  ["<C-j>"] = { "select_next", "fallback" },
  ["<C-space>"] = { "show", "show_documentation", "hide_documentation", "hide" },
  ["K"] = { "show_signature", "hide_signature", "fallback" },
  ["<Tab>"] = {
    function(cmp)
      if cmp.snippet_active() then
        return cmp.accept()
      else
        return cmp.select_and_accept()
      end
    end,
    "snippet_forward",
    "fallback",
  },
  ["<C-y>"] = { "select_and_accept", "fallback" },
  ["<Esc>"] = { "cancel", "fallback" },
}

---@module 'lazy'
---@type LazySpec
return {
  "saghen/blink.cmp",
  commit = "52cd2aae77db635af85d6e642fe19c56782c0e5c",
  event = { "InsertEnter", "CmdlineEnter" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    cmdline = {
      enabled = true,
      completion = {
        menu = {
          auto_show = true,
        },
      },
      keymap = keymap,
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    keymap = keymap,
    fuzzy = {
      implementation = "lua",
    },
  },
}
