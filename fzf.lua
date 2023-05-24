local csv = require('thecsv')

local fzf = "bat /Users/maxde/code/interpreting/aguila/billing/05-20-2023-copy.csv -p -f | fzf --reverse --prompt='monstrous' --ansi --margin=2 --padding=2 --header-lines=1 --no-multi"

local function capture(cmd, raw)
  local choice = assert(io.popen(cmd, 'r'))
  local s = assert(choice:read("*all"))
  choice:close()
  if raw then return s end
  s = s:gsub('^%s+', '')
  s = s:gsub('%s+$', '')
  s = s:gsub('[\n\r]+', '')
  return s
end

local choice = capture(fzf)
print("This is coming from in Lua", choice)
print(csv.CsvToString(choice))
