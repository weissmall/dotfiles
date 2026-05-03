-- local util = require("lspconfig/util")
-- require("mason").setup({})

vim.keymap.set("n", "<leader>lsr", vim.cmd.LspRestart)

-- local capabilities = vim.lsp.protocol.make_client_capabilities()



local function bindKeys(bufnr)
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
  -- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  -- nmap("<leader>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, "[W]orkspace [L]ist Folders")

  -- Diagnostic
  nmap("dn", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
  nmap("dp", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")
end

local function buffer_format(bufnr)
  local group = "lsp_autoformat"
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = group,
    desc = "LSP format on save",
    callback = function()
      -- note: do not enable async formatting
      vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
      -- vim.notify(tostring(group))
    end,
  })

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP Actions",
  callback = function(event)
    local opts = {
      buffer = event.buf,
    }
    local id = vim.tbl_get(event, "data", "client_id")
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
      return
    end

    -- Setup autoformat
    if client.supports_method("textDocument/formatting") then
      buffer_format(event.buf)
    end

    -- Setup keybinds
    bindKeys(opts.buffer)
  end,
})

-- local lspConfig = require("lspconfig")

-- lspConfig.eslint.setup({
--   settings = {
--     codeAction = {
--       disableRuleComment = {
--         enable = true,
--         location = "separateLine",
--       },
--       showDocumentation = {
--         enable = true,
--       },
--     },
--     codeActionOnSave = {
--       enable = false,
--       mode = "all",
--     },
--     experimental = {
--       useFlatConfig = false,
--     },
--     format = true,
--     nodePath = "",
--     onIgnoredFiles = "off",
--     problems = {
--       shortenToSingleLine = false,
--     },
--     quiet = false,
--     rulesCustomizations = {},
--     run = "onType",
--     useESLintClass = false,
--     validate = "on",
--     workingDirectory = {
--       mode = "location",
--     },
--   },
-- })

-- lspConfig.rust_analyzer.setup({
--   on_attach = function(client)
--     require("completion").on_attach(client)
--   end,
--   capabilities = capabilities,
--   settings = {
--     ["rust-analyzer"] = {
--       imports = {
--         granularity = {
--           group = "module",
--         },
--         prefix = "self",
--       },
--       cargo = {
--         features = {
--           "client",
--           "server",
--         },
--         buildScripts = {
--           enable = true,
--         },
--       },
--       procMacro = {
--         enable = true,
--       },
--     },
--   },
-- })

-- lspConfig.gopls.setup({
--   capabilities = capabilities,
--   cmd = { "gopls" },
--   filetypes = { "go", "go.mod" },
--   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--   -- settings = {
--   -- 	gopls = {
--   -- 		analyses = {
--   -- 			unusedparams = true,
--   -- 			shadow = true,
--   -- 		},
--   -- 		staticcheck = true,
--   -- 	},
--   -- },
-- })
--
--
--
--
-- https://microsoft.github.io/pyright/#/settings
-- lspConfig.pyright.setup({
--   capabilities = capabilities,
--   python = {
--     analysis = {
--       autoSearchPaths = true,
--       diagnosticMode = "workspace",
--     },
--   },
-- })

-- lspConfig.clangd.setup({
--   capabilities = vim.tbl_extend("keep", capabilities, {
--     offsetEncoding = { "utf-8", "utf-16" },
--     textDocument = {
--       completion = {
--         editsNearCursor = true,
--       },
--     },
--   }),
--   init_options = {
--     usePlaceholders = true,
--     completeUnimported = true,
--     clangdFileStatus = true,
--     semanticHighlighting = true,
--   },
--   filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
--   single_file_support = true,
--   root_markers = {
--     ".clangd",
--     ".clang-tidy",
--     ".clang-format",
--     "compile_commands.json",
--     "compile_flags.txt",
--     "configure.ac",
--     ".git",
--   },
--   root_dir = util.root_pattern(
--     ".clangd",
--     ".clang-tidy",
--     ".clang-format",
--     "compile_commands.json",
--     "compile_flags.txt",
--     "configure.ac",
--     ".git"
--   ),
--   cmd = {
--     "clangd",
--     "--background-index",
--     "--clang-tidy",
--     "--header-insertion=iwyu",
--     "--completion-style=detailed",
--     "--function-arg-placeholders",
--   },
-- })

-- lspConfig.dcmls.setup({
-- 	cmd = {
-- 		"dcm",
-- 		"start-server",
-- 		"--client=neovim",
-- 	},
-- 	filetypes = {
-- 		"dart",
-- 	},
-- 	root_dir = util.root_pattern("pubspec.yaml"),
-- })

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

-- lspConfig.cmake.setup({
--   cmd = { "cmake-language-server" },
--   filetypes = { "cmake" },
--   init_options = "build",
--   root_dir = util.root_pattern("CmakePresets.json", ".git", "build", "cmake", "CMakeLists.txt"),
--   single_file_support = true,
-- })
--
-- lspConfig.gdscript.setup({
--   filetypes = {
--     "gd",
--     "gdscript",
--     "gdscript3",
--   },
--   root_dir = util.root_pattern("project.godot", ".git"),
-- })

-- lspConfig.ts_ls.setup({
--   on_attach = function(client, bufnr)
--     require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
--   end,
--   filetypes = {
--     "javascript",
--     "typescript",
--     "typescriptreact",
--   },
-- })

-- lspConfig.cssls.setup({
--   filetypes = { "css", "scss", "less" },
--   init_options = {
--     -- provideFormatter = false,
--   },
--   settings = {
--     css = {
--       validate = true,
--     },
--     less = {
--       validate = true,
--     },
--     scss = {
--       validate = true,
--     },
--   },
-- })

-- lspConfig.svelte.setup({
--   cmd = {
--     "svelteserver",
--     "--stdio",
--   },
--   filetypes = { "svelte" },
--   root_dir = util.root_pattern("package.json"),
-- })

-- lspConfig.jsonls.setup({
--   capabilities = capabilities,
-- })

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

-- lspConfig.docker_compose_language_service.setup({
--   cmd = { "docker-compose-langserver", "--stdio" },
--   filetypes = { "yaml.docker-compose", "yml.docker-compose", "yaml" },
--   root_dir = util.root_pattern("docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"),
--   single_file_support = true,
-- })

-- lspConfig.groovyls.setup({
--   -- 	cmd = { "java", "-jar", "groovy-language-server-all.jar" },
--   filetypes = { "groovy" },
--   single_file_support = true,
-- })
--
-- lspConfig.kotlin_language_server.setup({
--   filetypes = "kotlin",
--   capabilities = capabilities,
-- })

-- lspConfig.postgres_lsp.setup({
-- 	capabilities = capabilities,
-- 	filetypes = { "sql" },
-- })

-- lspConfig.qmlls.setup({
--   capabilities = capabilities,
--   cmd = { "qmlls", "-E" }
-- })

-- lspConfig.ccls.setup {
--   init_options = {
--     cache = {
--       directory = ".ccls-cache",
--     },
--   },
--   on_attach = function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--     local lopts = { loclist = true }
--     -- ...
--     vim.keymap.set('n', 'gxb', function() get_location('$ccls/inheritance', {}, lopts) end, opts)
--     vim.keymap.set('n', 'gxB', function() get_location('$ccls/inheritance', { levels = 3 }, lopts) end, opts)
--     vim.keymap.set('n', 'gxd', function() get_location('$ccls/inheritance', { derived = true }, lopts) end, opts)
--     vim.keymap.set('n', 'gxD', function() get_location('$ccls/inheritance', { derived = true, levels = 3 }, lopts) end,
--       opts)
--     vim.keymap.set('n', 'gxc', function() get_location('$ccls/call', {}, lopts) end, opts)
--     vim.keymap.set('n', 'gxC', function() get_location('$ccls/call', { callee = true }, lopts) end, opts)
--     vim.keymap.set('n', 'gxs', function() get_location('$ccls/member', { kind = 2 }, lopts) end, opts)
--     vim.keymap.set('n', 'gxf', function() get_location('$ccls/member', { kind = 3 }, lopts) end, opts)
--     vim.keymap.set('n', 'gxm', function() get_location('$ccls/member', {}, lopts) end, opts)
--     vim.keymap.set('n', '<C-j>', function() get_location('$ccls/navigate', { direction = 'D' }, lopts) end, opts)
--     vim.keymap.set('n', '<C-k>', function() get_location('$ccls/navigate', { direction = 'U' }, lopts) end, opts)
--     vim.keymap.set('n', '<C-h>', function() get_location('$ccls/navigate', { direction = 'L' }, lopts) end, opts)
--     vim.keymap.set('n', '<C-l>', function() get_location('$ccls/navigate', { direction = 'R' }, lopts) end, opts)
--   end,
-- }

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.diagnostic.config({
  float = {
    source = true,
    border = "rounded",
  },
})
