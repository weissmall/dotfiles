---@module 'lazy'
---@type LazySpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    version = "v0.10.0",
    lazy = false,
    opts = {
      install_dir = vim.fn.stdpath('data') .. '/site',
      modules = {},
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust" },
      sync_install = false,
      auto_install = true,
      ignore_install = { "javascript" },
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  {
    "nvim-treesitter/playground",
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
