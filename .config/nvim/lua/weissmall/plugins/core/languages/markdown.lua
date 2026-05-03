return {
  "MeanderingProgrammer/render-markdown.nvim",
  init = function(_)
    vim.treesitter.language.register("markdown", "telekasten")
  end,
  opts = {
    file_types = {
      "markdown", "vimwiki"
    },
  },
  ft = { "markdown", "vimwiki" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
  },
}
