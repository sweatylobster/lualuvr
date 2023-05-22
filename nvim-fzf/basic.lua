local nvim_fzf = require('fzf')

-- ok so put strings in table to select one of them
coroutine.wrap(function ()
  local result = nvim_fzf.fzf({'hi max haha', 'wow this is the second option', 'maybe i can be third :)'})
  if result then
    -- and then do stuff with the selection
    print(result[1])
  end
end) ()
