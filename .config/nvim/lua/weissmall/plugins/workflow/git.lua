---@module "lazy"
---@type LazySpec[]
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts = opts or {}
      return vim.tbl_deep_extend(
        "force",
        opts,
        ---@module "gitsigns"
        ---@type Gitsigns.Config
        {
          current_line_blame = true,
        }
      )
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    lazy = true,
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>gs",
        vim.cmd.Git,
        mode = "n",
      },
      {
        "<leader>gaa",
        "<Cmd>Git add .<CR>",
        mode = "n",
      },
      {
        "<leader>gl",
        "<Cmd>Git pull<CR>",
        mode = "n",
      },
      {
        "<leader>gp",
        "<Cmd>Git push<CR>",
        mode = "n",
      },
      {
        "<leader>gst",
        "<Cmd>Git status<CR>",
        mode = "n",
      },
      {
        "<leader>gc",
        "<Cmd>Git commit<CR>",
        mode = "n",
      },
    },
  },
}
