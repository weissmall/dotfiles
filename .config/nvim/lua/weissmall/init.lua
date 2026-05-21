require("weissmall.set")
require("weissmall.remap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "weissmall.plugins" },
  { import = "weissmall.plugins.core" },
  { import = "weissmall.plugins.core.languages" },
  { import = "weissmall.plugins.utils" },
  { import = "weissmall.plugins.workflow" },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  -- },
  -- {
  --   "nvim-treesitter/playground",
  --   lazy = true,
  -- },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    enabled = false,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
  },
  {
    "Joakker/lua-json5",
    build = "./install.sh",
  },
  -- Tests
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "sidlatau/neotest-dart",
      "marilari88/neotest-vitest",
    },
    lazy = true,
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
  },
  -- Debugging

  { "jay-babu/mason-nvim-dap.nvim" },
  {
    "MunifTanjim/prettier.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
  },
  { "vidocqh/auto-indent.nvim" },
  -- { "abecodes/tabout.nvim" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  -- Detect tabstop and shiftwidth automatically
  {
    "tpope/vim-sleuth",
    lazy = true,
  },

  { "xiyaowong/transparent.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  },
  {
    url = "https://codeberg.org/elfahor/telescope-just.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    enabled = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "benfowler/telescope-luasnip.nvim",
      "saadparwaiz1/cmp_luasnip",
    },
    version = "v2.*",
    build = "make install_jsregexp",
  },
  -- Powerline
  { "nvim-lualine/lualine.nvim" },

  -- Neovim development
  { "Bilal2453/luvit-meta",      lazy = true }, -- optional `vim.uv` typings

  -- Startup dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
  },
  -- Golang
  {
    "olexsmir/gopher.nvim",
    lazy = true,
  },

  -- Formatting
  { "mhartington/formatter.nvim", cond = false },

  -- VimBeGood
  ---@type LazySpec
  {
    "ThePrimeagen/vim-be-good",
    lazy = true,
    cmd = "VimBeGood",
  },

  -- UI Hooks
  { "stevearc/dressing.nvim" },

  -- Startup time
  {
    "dstein64/vim-startuptime",
    lazy = true,
    cmd = "StartupTime",
  },
})
