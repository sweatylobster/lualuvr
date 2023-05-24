-- Returns stdout of a command as a string.
local function capture(command, raw)
  local f = assert(io.popen(command, 'r'))
  local s = assert(f:read("*all"))
  f:close()
  if raw then return s end
  s = s:gsub('^%s+', '')
  s = s:gsub('%s+$', '')
  s = s:gsub('[\n\r]+', '')
  return s
end

-- Returns stdout of a command as a table.
local function tab_cap(command)
  local a = {}
  local f = assert(io.popen(command, 'r'))
  assert(f:lines('a'))
  for l in f:lines() do
    table.insert(a, l)
  end
  return a
end

-- Sets defaults fd and fzf.
local mac = {
  fd = "fd -t f .csv -d 1 --search-path=/Users/maxdehoyos/code/aguila/billing",
  fzf = "| fzf --delimiter='/' --with-nth=7 --tac",
}

-- local a = {"cow", "sow", "monstrow"}
local b = tab_cap(mac.fd)

local s = table.concat(b, " ")
local n = table.concat(b, "\n")

local function gum_choose(choices)
  local c = assert(io.popen('gum choose --header="Choose a day, cutie!" ' .. choices, 'r'))
  local gum_table = c:read('a')
  return gum_table
end

print("This is the day you chose!", gum_choose(s))
