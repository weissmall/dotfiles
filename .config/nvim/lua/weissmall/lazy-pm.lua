local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
	{ "xiyaowong/transparent.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Themes
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"nvim-treesitter/playground",
	"theprimeagen/harpoon",
	"tpope/vim-fugitive",
	"mbbill/undotree",

	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/nvim-cmp" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"benfowler/telescope-luasnip.nvim",
			"saadparwaiz1/cmp_luasnip",
		},
		version = "v2.*",
		build = "make install_jsregexp",
	},
	{ "akinsho/flutter-tools.nvim" },
	-- Powerline
	{ "nvim-lualine/lualine.nvim" },

	-- Neovim development
	{ "folke/neodev.nvim", opts = {} },

	-- Terminal
	{ "akinsho/toggleterm.nvim", version = "*", config = true },

	-- Rust
	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^3", -- Recommended
	-- 	ft = { "rust" },
	-- },
	-- Project management
	{ "ahmedkhalf/project.nvim" },

	-- Startup dashboard
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		cmd = "Telescope projects",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
	},

	-- File tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- Barbecue (breadcrumbs like line)
	{
		"utilyre/barbecue.nvim",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- Opened windows bar
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		version = "*",
	},

	-- Notifications
	{ "rcarriga/nvim-notify" },

	-- Golang
	{ "olexsmir/gopher.nvim" },

	-- Formatting
	{ "mhartington/formatter.nvim" },

	-- VimBeGood
	{ "ThePrimeagen/vim-be-good" },

	-- Python envs
	{ "AckslD/swenv.nvim" },

	-- UI Hooks
	{ "stevearc/dressing.nvim" },

	-- Which key
	{ "folke/which-key.nvim" },
})
