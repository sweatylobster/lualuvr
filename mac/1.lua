--
-- what about something like

local ipython_history = {}

-- coroutine.wrap(function()
--   local result = nvim_fzf.fzf(ipython_history)
--   if result then
--     vim.api.paste(result[1])
--     vim.api.nvim_get_buf_name(0)
--   end
-- end)()
--
local function hello()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. 'hello' .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
end


co = coroutine.create(function (a)
  coroutine.yield(a + 2)
end)()

print(coroutine.resume(co, 4))
