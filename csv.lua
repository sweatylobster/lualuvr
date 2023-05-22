M = {}

-- example fzf output when reading from a schedule file
local ss = "4,Max de Hoyos,04/02/1995,Mehrdad Shademan,05/10/2023"
local sd = "4,Max de Hoyos,04-02-1995,Mehrdad Shademan,05-10-2023"


-- we find we can get all of the values and store them in indices.
local r = {}
for i in string.gmatch(ss, ",?([%d%-/%a%s]+)") do
  table.insert(r, i)
end

-- now we want to store them in k-v pairs.

-- here they are.
local keys = {'#', 'name', 'dob', 'doctor', 'dos'}

-- ss.sequence == keys.sequence -->
local function key_value_table(t)
  for i, x in ipairs(t) do
    t[keys[i]] = x
  end
  return t
end

local a = key_value_table(r)

-- great. now let's get a string representation of the table to pass in on the command line and turn into a lua object (in another lua session.)
-- but this is the X Y problem.
-- i want to print what i choose to print.
-- i want to choose with fzf and send to a lualatex process.
-- i can output the .csv string to the lualatex file.
-- or i can do the whole lualatex compile command as a lua coroutine.
-- this way, i just call io.read() within this script, which is bound to a key combination in fzf.
-- --bind 'ctrl-l:execute(lua ~/luastuff/csv.lua {})'
sr = ""
--
-- for i, x in pairs(a) do
--   print(i, x)
-- end
