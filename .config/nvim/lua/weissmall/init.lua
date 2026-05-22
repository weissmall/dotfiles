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
    opts = {
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

    },
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
  },
  {
    "vidocqh/auto-indent.nvim",
    opts = {
      lightmode = true,
      indentexpr = nil,
      ignore_filetype = {},
    },
  },
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

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      -- Optional, you don't have to run setup.
      groups = { -- table: default groups
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLine",
        "CursorLineNr",
        "StatusLine",
        "StatusLineNC",
        "EndOfBuffer",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
      },
      extra_groups = {
        "Telescope",
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptBorder",
        "TelescopePromptTitle",
        "NoicePopupBorder",
        "NoiceSplitBorder",
        "FloatBorder",
        "NormalFloat",
        "Barbar",
        "neo-tree",
      }, -- table: additional groups that should be cleared
      exclude_groups = {
        "Buffer",
      }, -- table: groups you don't want to clear

    },
  },
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
  -- Neovim development
  { "Bilal2453/luvit-meta",        lazy = true }, -- optional `vim.uv` typings

  -- Startup dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {
      theme = "doom",
      config = {
        week_header = {
          enable = true,
        },
        disable_mode = true,
        vertical_center = true,
        center = {
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Find File",
            desc_hl = "String",
            key = "ff",
            keymap = "<leader>",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "lua print(2)",
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Find Grep",
            desc_hl = "String",
            key = "fg",
            keymap = "<leader>",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "lua print(2)",
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Quick jump",
            desc_hl = "String",
            key = "e",
            keymap = "<leader>",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "lua print(2)",
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "File Tree",
            desc_hl = "String",
            key = "ft",
            keymap = "<leader>",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "lua print(2)",
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Another File Manager",
            desc_hl = "String",
            key = "fm",
            keymap = "<leader>",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "lua print(2)",
          },
          {
            icon = " ",
            icon_hl = "Title",
            desc = "Quit",
            desc_hl = "String",
            key = "qa",
            keymap = "<leader>",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "lua print(2)",
          },
        },
        footer = {},
      },

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
