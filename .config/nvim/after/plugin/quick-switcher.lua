local qs = require("nvim-quick-switcher")

local function find_by_fn(fn, opts)
	return function()
		qs.find_by_fn(fn, opts)
	end
end

local find_test_fn = function(p)
	local path = p.path
	local file_name = p.prefix
	local result = path:gsub("lib", "test") .. "/" .. p.prefix .. "*"
	return result
end

local find_src_fn = function(p)
	local path = p.path
	local file_name = p.prefix
	local result = path:gsub("test", "lib") .. "/" .. p.prefix .. "*"
	return result
end

vim.keymap.set("n", "<leader>gt", find_by_fn(find_test_fn))
vim.keymap.set("n", "<leader>gs", find_by_fn(find_src_fn))
