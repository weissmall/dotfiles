local lsp = require("lsp-zero")

vim.keymap.set("n", "<leader>lsr", vim.cmd.LspRestart)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	-- Prettier section
	local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
	local event = "BufWritePre" -- or "BufWritePost"
	if client.supports_method("textDocument/formatting") then
		vim.keymap.set("n", "<Leader>f", function()
			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
		end, { buffer = bufnr, desc = "[lsp] format" })

		-- format on save
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
		vim.api.nvim_create_autocmd(event, {
			buffer = bufnr,
			group = group,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr, async = true })
			end,
			desc = "[lsp] format on save",
		})
	end

	if client.supports_method("textDocument/rangeFormatting") then
		vim.keymap.set("x", "<Leader>f", function()
			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
		end, { buffer = bufnr, desc = "[lsp] format" })
	end
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup({})
local mason_lsp = require("mason-lspconfig")

mason_lsp.setup({
	ensure_installed = {
		"lua_ls",
	},
	sources = {
		"nvim_lsp",
		"luasnip",
	},
	handlers = {
		lsp.default_setup,
	},
})

local cmp = require("cmp")
local compare = require("cmp.config.compare")

cmp.setup({
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
		},
		{
			name = "luasnip",
		},
	}),
	-- :help cmp-config.sorting.comparators
	sorting = {
		priority_weight = 1.0,
		comparators = {
			function(t1, t2)
				return compare.kind(t1, t2)
			end,
			compare.order,
			compare.exact,
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<Esc>"] = cmp.mapping.abort(),
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
		["<C-h>"] = cmp.mapping.abort(),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = "insert" }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "insert" }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

local lspConfig = require("lspconfig")
-- local neodev = require("neodev")

-- neodev.setup({
-- 	library = {
-- 		plugins = true,
-- 	},
-- })
--
-- neodev.setup({
-- library = {
-- 	plugins = {
-- 		"lazy",
-- 		"neotest",
-- 		"nvim-dap",
-- 		"nvim-dap-ui",
-- 		"toggleterm",
-- 		"neotest-dart",
-- 		"neotest-vitest",
-- 		"markdown-preview",
-- 		"flutter-tools",
-- 		"nvim-tree",
-- 		"wilder",
-- 	},
-- 	types = true,
-- },
-- })

lspConfig.lua_ls.setup({
	n_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = {
					vim.api.nvim_get_runtime_file("", true),
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$HOME/.local/share/nvim")] = true,
				},
			},
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

lspConfig.rust_analyzer.setup({
	on_attach = function(client)
		require("completion").on_attach(client)
		on_attach()
	end,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				features = {
					"client",
					"server",
				},
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})
local util = require("lspconfig/util")

lspConfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "go.mod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
})
-- https://microsoft.github.io/pyright/#/settings
lspConfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	python = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = "workspace",
		},
	},
})

lspConfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
		semanticHighlighting = true,
	},
	single_file_support = true,
	root_dir = util.root_pattern(
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git"
	),
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
	},
})

local flutter = require("flutter-tools")
-- flutter.setup({
-- 	root_patterns = {
-- 		".git",
-- 		"pubspec.yaml",
-- 	},
-- 	lsp = {
-- 		capabilities = capabilities,
-- 		on_attach = on_attach,
-- 		settings = {
-- 			showTodos = true,
-- 			completeFunctionCalls = true,
-- 			enableSnippets = true,
-- 			updateImportsOnRename = true,
-- 		},
-- 	},
-- 	-- lsp = {
-- 	-- 	color = { -- show the derived colours for dart variables
-- 	-- 		enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
-- 	-- 		background = false, -- highlight the background
-- 	-- 		background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
-- 	-- 		foreground = false, -- highlight the foreground
-- 	-- 		virtual_text = true, -- show the highlight using virtual text
-- 	-- 		virtual_text_str = "■", -- the virtual text character to highlight
-- 	-- 	},
-- 	-- 	settings = {
-- 	-- 		showTodos = true,
-- 	-- 		completeFunctionCalls = true,
-- 	-- 		analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
-- 	-- 		renameFilesWithClasses = "prompt", -- "always"
-- 	-- 		enableSnippets = true,
-- 	-- 		updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
-- 	-- 	},
-- 	-- },
-- })
--
flutter.setup({
	ui = {
		border = "rounded",
		notification_style = "plugin",
	},
	decorations = {
		statusline = {
			app_version = true,
			device = true,
			project_config = false,
		},
	},
	-- debugger = {
	-- 	enabled = true,
	-- 	run_via_dap = true,
	-- 	exception_breakpoints = {},
	-- },
	debugger = {
		enabled = true,
		-- run_via_dap = true,
		exception_breakpoints = {},
		evaluate_to_string_in_debug_views = false,
	},
	fvm = false,
	dev_log = {
		enabled = false,
	},
	lsp = {
		color = {
			enabled = false,
			background = true,
			background_color = nil,
			foreground = false,
			virtual_text = true,
			virtual_text_str = "■",
		},
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			showTodos = true,
			completeFunctionCalls = true,
			-- analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
			renameFilesWithClasses = "always",
			enableSnippets = false,
			updateImportsOnRename = true,
		},
	},
})

lspConfig.dcmls.setup({
	cmd = {
		"dcm",
		"start-server",
		"--client=neovim",
	},
	filetypes = {
		"dart",
	},
	root_dir = util.root_pattern("pubspec.yaml"),
})

-- lspConfig.dartls.setup({
-- 	cmd = { "dart", "language-server", "--protocol=lsp" },
-- 	filetypes = { "dart" },
-- 	init_options = {
-- 		closingLabels = true,
-- 		flutterOutline = true,
-- 		onlyAnalyzeProjectsWithOpenFiles = true,
-- 		outline = true,
-- 		suggestFromUnimportedLibraries = true,
-- 	},
-- 	root_dir = util.root_pattern("pubspec.yaml"),
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	settings = {
-- 		dart = {
-- 			showTodos = true,
-- 			completeFunctionCalls = true,
-- 			enableSnippets = true,
-- 			updateImportsOnRename = true,
-- 		},
-- 		flutter = {
-- 			showTodos = true,
-- 			completeFunctionCalls = true,
-- 			enableSnippets = true,
-- 			updateImportsOnRename = true,
-- 		},
-- 	},
-- })

lspConfig.cmake.setup({
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	init_options = "build",
	root_dir = util.root_pattern("CmakePresets.json", ".git", "build", "cmake", "CMakeLists.txt"),
	single_file_support = true,
})

lspConfig.gdscript.setup({
	on_attach = on_attach,
	filetypes = {
		"gd",
		"gdscript",
		"gdscript3",
	},
	root_dir = util.root_pattern("project.godot", ".git"),
})

lspConfig.terraformls.setup({
	cmd = { "terraform-ls", "serve" },
})

lspConfig.ts_ls.setup({
	on_attach = on_attach,
	filetypes = {
		"javascript",
		"typescript",
	},
})

lspConfig.svelte.setup({
	cmd = {
		"svelteserver",
		"--stdio",
	},
	filetypes = { "svelte" },
	root_dir = util.root_pattern("package.json"),
})

lspConfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- lspConfig.yamlls.setup({
-- 	settings = {
-- 		redhat = {
-- 			telemetry = {
-- 				enabled = false,
-- 			},
-- 		},
-- 		yaml = {
-- 			schemas = {
-- 				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
-- 			},
-- 		},
-- 	},
-- })

lspConfig.docker_compose_language_service.setup({
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose", "yml.docker-compose", "yaml" },
	root_dir = util.root_pattern("docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"),
	single_file_support = true,
})

lspConfig.dockerls.setup({
	settings = {
		docker = {
			languageserver = {
				formatter = {
					ignoreMultilineInstructions = true,
				},
			},
		},
	},
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_dir = util.root_pattern("Dockerfile"),
	single_file_support = true,
})

lspConfig.groovyls.setup({
	-- 	cmd = { "java", "-jar", "groovy-language-server-all.jar" },
	filetypes = { "groovy" },
	single_file_support = true,
})

lsp.setup()
