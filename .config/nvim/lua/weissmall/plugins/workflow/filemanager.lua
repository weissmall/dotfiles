---@module 'lazy'
---@type LazySpec
return {
	---@type LazySpec
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
	---@type LazySpec
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			filesystem = {
				follow_current_file = {
					enabled = true,
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
