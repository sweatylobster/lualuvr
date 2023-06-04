local nvim_fzf = require('fzf')

coroutine.wrap(function()
  local result = nvim_fzf.fzf({"hi i'm greting thrungaburg", "i should be in school", "you should be ashasmed of urslevls"})
  if result then
    print(result[1])
  end
end)()
