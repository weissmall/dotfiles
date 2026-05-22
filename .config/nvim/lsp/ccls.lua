---@param method string
---@param opts? vim.lsp.LocationOpts
local function get_location(method, params, opts)
  opts = opts or {}
  params = params or {}
  local bufnr = api.nvim_get_current_buf()
  local clients = lsp.get_clients({ method = method, bufnr = bufnr })
  if not next(clients) then
    vim.notify(lsp._unsupported_method(method), vim.log.levels.WARN)
    return
  end
  local win = api.nvim_get_current_win()
  local from = vim.fn.getpos(".")
  from[1] = bufnr
  local tagname = vim.fn.expand("<cword>")
  local remaining = #clients

  ---@type vim.quickfix.entry[]
  local all_items = {}

  ---@param result nil|lsp.Location|lsp.Location[]
  ---@param client vim.lsp.Client
  local function on_response(_, result, client)
  end
  for _, client in ipairs(clients) do
    local lparams = util.make_position_params(win, client.offset_encoding)
    for k, v in pairs(params) do
      lparams[k] = v
    end
    client:request(method, lparams, function(_, result)
      on_response(_, result, client)
    end)
  end
end

---@type vim.lsp.Config
return {
  init_options = {
    cache = {
      directory = ".ccls-cache",
    },
  },
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local lopts = { loclist = true }
    -- ...
    vim.keymap.set('n', 'gxb', function() get_location('$ccls/inheritance', {}, lopts) end, opts)
    vim.keymap.set('n', 'gxB', function() get_location('$ccls/inheritance', { levels = 3 }, lopts) end, opts)
    vim.keymap.set('n', 'gxd', function() get_location('$ccls/inheritance', { derived = true }, lopts) end, opts)
    vim.keymap.set('n', 'gxD', function() get_location('$ccls/inheritance', { derived = true, levels = 3 }, lopts) end,
      opts)
    vim.keymap.set('n', 'gxc', function() get_location('$ccls/call', {}, lopts) end, opts)
    vim.keymap.set('n', 'gxC', function() get_location('$ccls/call', { callee = true }, lopts) end, opts)
    vim.keymap.set('n', 'gxs', function() get_location('$ccls/member', { kind = 2 }, lopts) end, opts)
    vim.keymap.set('n', 'gxf', function() get_location('$ccls/member', { kind = 3 }, lopts) end, opts)
    vim.keymap.set('n', 'gxm', function() get_location('$ccls/member', {}, lopts) end, opts)
    vim.keymap.set('n', '<C-j>', function() get_location('$ccls/navigate', { direction = 'D' }, lopts) end, opts)
    vim.keymap.set('n', '<C-k>', function() get_location('$ccls/navigate', { direction = 'U' }, lopts) end, opts)
    vim.keymap.set('n', '<C-h>', function() get_location('$ccls/navigate', { direction = 'L' }, lopts) end, opts)
    vim.keymap.set('n', '<C-l>', function() get_location('$ccls/navigate', { direction = 'R' }, lopts) end, opts)
  end,
}
