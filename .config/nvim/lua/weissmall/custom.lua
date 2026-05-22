local function customLineReplace()
  local pos = vim.fn.line(".")
  -- Yank to register
  vim.cmd.normal('"zyy')

  -- Get yanked
  local value = string.gsub(vim.fn.getreg('"z'), "%s+", "")
  local len = string.len(value)
  local leftLen = 72

  local leftInsert = math.floor((leftLen - len) / 2)
  local rightInsert = leftInsert + ((leftLen - len) % 2)

  local line = "/* " .. string.rep("-", leftInsert) .. " " .. value .. " " .. string.rep("-", rightInsert) .. " */"

  vim.fn.setline(pos, line)
end

local function customLine()
  local pos = vim.fn.line(".")
  local line = "/* " .. string.rep("-", 74) .. " */"
  vim.fn.setline(pos, line)
end

vim.keymap.set("n", "<leader>cl", customLine)
vim.keymap.set("n", "<leader>clr", customLineReplace)

--- Git push
local function gitPushOrigin()
  local handle = io.popen("git rev-parse --abbrev-ref HEAD")
  if handle == nil then
    return
  end
  local result = handle:read("*l")
  handle:close()

  local command = "Git push origin " .. result
  vim.api.nvim_command(command)
end

vim.keymap.set("n", "<leader>ggp", gitPushOrigin)
