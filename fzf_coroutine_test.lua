-- here's the file we're messing with
io.input(arg[1])
io.output(arg[1])

-- local schedule = assert(io.open(arg[1], 'r'))
-- local lines = schedule:read("*all")
-- schedule:close()
--
--
-- because we're going to be manipulating this file, we don't want to have a default
-- local file = "/Users/maxde/code/interpreting/aguila/billing/05-20-2023-copy.csv"
-- local bat = "bat -p -f"
-- local fzf = fzf --reverse --prompt='monstrous' --ansi --margin=2 --padding=2 --header-lines=1 --no-multi
--
local path = "C:\\Users\\maxde\\code\\interpreting\\aguila\\billing\\"
local file = "05-20-2023-copy.csv"
local fzf = "bat -p -f " .. path .. file .. '| fzf --reverse --prompt="monstrous use of lua bro > " --ansi --margin=2 --padding=2 --header-lines=1 --no-multi'
local gum_today = 'gum input --placeholder="you wanna read today\'s schedule?"'
local gum_else = 'gum filter'
local fd = "fd -t f '.csv' " .. path


-- read the output of a command.
local function read_cmd(command, raw)
  local f = assert(io.popen(command, 'r'))
  local s = assert(f:read("*all"))
  f:close()
  if raw then return s end
  s = s:gsub('^%s+', '')
  s = s:gsub('%s+$', '')
  s = s:gsub('[\n\r]+', '')
  return s
end


local function get_csv_fields(csv_line)
  local t = {}
  for i in string.gmatch(csv_line, ",?([%d%-/%a%s]+)") do
    table.insert(t, i)
  end
  return t
end

-- turn it into a table
local function csv_to_table(csv_line)
  local a = {}
  local keys = {'line', 'name', 'dob', 'doctor', 'dos'}
  local fields = get_csv_fields(csv_line)
  for i, x in ipairs(fields) do
    if i == 1 then end
    a[keys[i]] = x
  end
  return a
end


-- this is so fkn jank lmao
local function csv_to_string(csv_line)
  local a = {}
  table.insert(a, "{ ")
  local keys = {'line', 'name', 'dob', 'doctor', 'dos'}
  local fields = get_csv_fields(csv_line)
  for i, v in ipairs(fields) do
    table.insert(a, keys[i] .. "=" .. '"' .. v .. '"' .. ',')
  end
  table.insert(a, " }")
  return table.concat(a)
end


-- https://www.lua.org/pil/21.2.html
-- we can use the complete aka stream model but it's a bit much
-- we just want to iterate through the table of lines
-- remove the line in question
-- and write back to the file (or another file)
local function purge_line(line_in_question)
  local f = io.read("*all")  -- so read the original 
  f:gsub(line_in_question, "")  -- remove the appropriate line
  io.write(f)-- write back
end

-- only run this if there's no argument
-- but if no arg, then 
local function gum_prompt()
  local use_today = read_cmd('gum choose "yes" "no" --header="Use today\'s schedule?"', false)
  if use_today == 'yes' then
    local today_format = os.date("%m-%d-%Y")
    print("here's today:", today_format)
    return today_format
  elseif use_today == 'no' then
    local header = '--header="Well then which file do you wanna read?"'
    local fd_cmd = 'fd -d 1 -t f csv ' .. path
    fzf_del_cmd = 'fzf --delimiter="\" --with-nth=48..100'
    local fd_filter = fd_cmd .. ' | ' .. 'fzf --delimiter="\" --with-nth=7'
    local files = read_cmd(fd_filter)
    -- for i, x in ipairs(files) do
    --   print(i, x)
    -- end
  end
end

gum_prompt()

-- local choice = coroutine.wrap(function ()
--   gum_prompt()
--   coroutine.yield(read_cmd(fzf))
-- end) ()
--
-- print('chosen fzf line from main', choice)
--
-- local tb = csv_to_table(choice)
-- print('Subsettable name: ', tb.name)
-- -- if gsub gives you ability to number matches
-- -- for i in s:gsub(pat) do k[i] .. = .. v[i]
-- -- damn dude i sleepy
--
-- -- print(table.concat(tb))
-- local repr = csv_to_string(choice)
-- print("And a representation of the table as a string!", repr)
--
-- print("\nWell done, Max!")
