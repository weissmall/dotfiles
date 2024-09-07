local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-dart")({
			command = "flutter",
			use_lsp = true,
		}),
		require("neotest-vitest")({
			vitestCommand = "npx vitest run",
		}),
	},
})

local function runCurrentTest()
	return neotest.run.run()
end

local function runFileTest()
	return neotest.run.run(vim.fn.expand("%"))
end

local function stopTest()
	return neotest.run.stop()
end

local function openPanel()
	return neotest.output_panel.open()
end

local function closePanel()
	return neotest.output_panel.close()
end

local function testSummaryOpen()
	return neotest.summary.open()
end

local function testSummaryClose()
	return neotest.summary.close()
end

local function testWatchFile()
	return neotest.watch.watch(vim.fn.expand("%"))
end

local function debugCurrent()
	return neotest.run.run({ strategy = "dap" })
end

vim.keymap.set("n", "<leader>tc", runCurrentTest)
vim.keymap.set("n", "<leader>tdc", debugCurrent)
vim.keymap.set("n", "<leader>twf", testWatchFile)
vim.keymap.set("n", "<leader>tf", runFileTest)
vim.keymap.set("n", "<leader>ts", stopTest)
vim.keymap.set("n", "<leader>tpo", openPanel)
vim.keymap.set("n", "<leader>tpc", closePanel)
vim.keymap.set("n", "<leader>tso", testSummaryOpen)
vim.keymap.set("n", "<leader>tssc", testSummaryClose)

vim.keymap.set("n", "<leader>twf", function()
	require("neotest").run.run({ vim.fn.expand(" % "), vitestCommand = "vitest --watch" })
end)
