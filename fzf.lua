local fzf = "bat /Users/maxde/code/interpreting/aguila/billing/05-20-2023-copy.csv -p -f | fzf --reverse --prompt='monstrous' --ansi --margin=2 --padding=2 --header-lines=1 --no-multi"

local function capture(cmd)
  local choice = assert(io.popen(cmd, 'r'))
  local s = assert(choice:read("*all"))
  choice:close()
  return s
end

print("This is coming from in Lua", capture(fzf))
