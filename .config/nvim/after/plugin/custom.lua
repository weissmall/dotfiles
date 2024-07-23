local function customLineReplace()
	local pos = vim.fn.line(".")
	-- Yank to register
	vim.cmd.normal('"zyy')

	-- Get yanked
	local value = string.gsub(vim.fn.getreg('"z'), "%s+", "")
	local len = string.len(value)
	local leftLen = 72
	local symLen = (leftLen - len) / 2
	local mod = leftLen % 2

	local line = "/* " .. string.rep("-", symLen) .. " " .. value .. " " .. string.rep("-", symLen + mod) .. " */"

	vim.fn.setline(pos, line)
end

local function customLine()
	local pos = vim.fn.line(".")
	local line = "/* " .. string.rep("-", 74) .. " */"
	vim.fn.setline(pos, line)
end

vim.keymap.set("n", "<leader>cl", customLine)
vim.keymap.set("n", "<leader>clr", customLineReplace)
