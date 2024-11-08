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
	require("weissmall.plugins.markdown").plugin,
	require("weissmall.plugins.pkl").plugin,
	require("weissmall.plugins.themes").catpuccin,
	-- require("weissmall.plugins.lazydev").lazydev,
	-- require("weissmall.plugins.lazydev").blink,
	{
		"folke/lazydev.nvim",
		dependencies = {
			"Bilal2453/luvit-meta",
			lazy = true,
		},
	},
	{
		"renerocksai/telekasten.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"tomasky/bookmarks.nvim",
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"famiu/bufdelete.nvim",
		},
	},
	{ "gelguy/wilder.nvim" },
	-- {
	-- 	"folke/noice.nvim",
	-- 	-- event = "VeryLazy",
	-- 	opts = {},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
	{
		"https://gitlab.com/itaranto/plantuml.nvim",
		version = "*",
		config = function()
			require("plantuml").setup({
				renderer = {
					type = "imv",
					format = "svg",
					options = {
						split_cmd = "vsplit",
					},
				},
				render_on_write = true,
			})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	-- Rofi syntax
	{
		"Fymyte/rasi.vim",
		ft = { "rasi" },
		lazy = true,
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	ft = "http",
	-- 	dependencies = { "luarocks.nvim" },
	-- 	config = function()
	-- 		require("rest-nvim").setup()
	-- 	end,
	-- },
	{
		"Joakker/lua-json5",
		build = "./install.sh",
	},
	{
		"Everduin94/nvim-quick-switcher",
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
	-- Plugin for firefox
	-- {
	-- 	"glacambre/firenvim",
	-- 	lazy = not vim.g.started_by_firenvim,
	-- 	build = function()
	-- 		vim.fn["firenvim#install"](0)
	-- 	end,
	-- 	lazy = true,
	-- },
	-- { "github/copilot.vim", deactivate = true },
	-- {
	-- 	"Civitasv/cmake-tools.nvim",
	-- 	branch = "main",
	-- 	opts = {
	-- 		cmake_build_directory = "build",
	-- 		cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
	-- 	},
	-- },
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
	},
	{ "chipsenkbeil/distant.nvim" },

	-- Debugging
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"mxsdev/nvim-dap-vscode-js",
			"microsoft/vscode-js-debug",
		},
		lazy = true,
	},

	{ "jay-babu/mason-nvim-dap.nvim" },
	{ "MunifTanjim/prettier.nvim" },
	{ "vidocqh/auto-indent.nvim" },
	{ "abecodes/tabout.nvim" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	-- Detect tabstop and shiftwidth automatically
	{ "tpope/vim-sleuth" },

	{ "xiyaowong/transparent.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	{
		url = "https://codeberg.org/elfahor/telescope-just.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
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

	{ "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
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
	{
		"akinsho/flutter-tools.nvim",
		lazy = true,
	},
	-- Powerline
	{ "nvim-lualine/lualine.nvim" },

	-- Neovim development
	-- { "folke/neodev.nvim",        opts = {} },
	-- {
	-- 	"folke/lazydev.nvim",
	-- 	-- dir = "~/dev/open-sos/lazydev.nvim",
	-- 	dependencies = { { "bilal2453/luvit-meta" } },
	-- 	ft = "lua",
	-- 	opts = {
	-- 		library = { "luvit-meta/library" },
	-- 	},
	-- 	init = function()
	-- 		local luadir = vim.fn.expand("~/.config/nvim/lua/")
	-- 		if not vim.loop.fs_stat(luadir) then
	-- 			vim.fn.mkdir(luadir)
	-- 		end
	-- 	end,
	-- },
	{ "Bilal2453/luvit-meta",     lazy = true }, -- optional `vim.uv` typings
	{                                       -- optional completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},

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
	-- {
	-- 	"romgrk/barbar.nvim",
	-- 	dependencies = {
	-- 		"lewis6991/gitsigns.nvim",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	init = function()
	-- 		vim.g.barbar_auto_setup = false
	-- 	end,
	-- 	version = "*",
	-- },

	-- Notifications
	{ "rcarriga/nvim-notify" },

	-- Golang
	{
		"olexsmir/gopher.nvim",
		lazy = true,
	},

	-- Formatting
	{ "mhartington/formatter.nvim" },

	-- VimBeGood
	{ "ThePrimeagen/vim-be-good" },

	-- Python envs
	{
		"AckslD/swenv.nvim",
		lazy = true,
	},

	-- UI Hooks
	{ "stevearc/dressing.nvim" },

	-- Which key
	{ "folke/which-key.nvim" },
})
