---@module 'lazy'
---@type LazySpec[]
return {
  {
    "echasnovski/mini.files",
    lazy = true,
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true, {})
        end,
        desc = "[F]ile[M]anager",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true, {})
        end,
        desc = "[F]ile[M]anager (cwd)",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      enable_diagnostics = true,
      enable_git_status = true,
      enable_modified_markers = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
    },
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>ft",
        "<cmd>Neotree<cr>",
      },
    },
  },
}
