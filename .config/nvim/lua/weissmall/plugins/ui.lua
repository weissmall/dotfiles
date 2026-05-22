local function cwdName()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.cyan },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}


---@module 'lazy'
---@type LazySpec[]
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    ---@module 'noice'
    ---@type NoiceConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1,
      background_colour = "#000000",
      level = 1,
      max_width = 30,
      max_height = 100,
      on_open = function() end,
      on_close = function() end,
      fps = 15,
    },
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>nd",
        function()
          require("notify").dismiss({
            pending = true,
            silent = true,
          })
        end,
        desc = "[N]otifications [D]elete",
      },
      {
        "<leader>nh",
        "<cmd>Noice telescope<cr>",
        desc = "[N]oice/[N]otification [H]istory",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      --- @module "bufferline"
      local bufferline = require("bufferline")

      bufferline.setup({
        options = {
          style_preset = {
            bufferline.style_preset.minimal,
            bufferline.style_preset.no_bold,
            bufferline.style_preset.no_italic,
          },
          separator_style = "thin",
          themable = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
        },
      })
    end
  },
  -- Breadcrumbs
  {
    "utilyre/barbecue.nvim",
    lazy = false,
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = vim.g.config.colorscheme,
      show_basename = true,
      show_navic = false,
    },
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>bb",
        "<cmd>Barbecue toggle<cr>"
      }
    },
  },
  -- Colorize ANSI text
  {
    "m00qek/baleia.nvim",
    conf = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        -- theme = bubbles_theme,
        theme = vim.g.config.colorscheme,
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          "lazy",
          "NvimTree",
          "toggleterm",
          -- "dapui_scopes",
          -- "dapui_breakpoints",
          -- "dapui_stacks",
          -- "dapui_watches",
          -- "dapui_console",
          -- "dap-repl",
        },
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = {
          function()
            return "(" .. cwdName() .. ")"
          end,
          "filename",
          "branch",
          function()
            local reg = vim.fn.reg_recording()
            if reg == "" then
              return ""
            end -- not recording
            return "recording to " .. reg
          end,
        },
        lualine_c = {
          "%=", --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},

    },
  },
}
