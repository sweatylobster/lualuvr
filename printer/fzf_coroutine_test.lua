-- write and read to this file
-- io.input(arg[1])
-- io.output(arg[1])
local M = {}

local preferences = require('preferences')
local commands = require('commands')
local capture = require('capture')

local cmd = {
  gum = {
    today = 'gum choose "yes" "no" --header="You wanna read today\'s schedule?"'},
  bat = 'bat -p -f',
  fd = "fd -t f .csv -d 1 --search-path=" .. billing,
  python = {
    get_schedule = "ipython " .. billing .. '/get_schedule.py'},
  fzf = 'fzf --ansi --reverse --margin=2 --padding=2 --header-lines=1 --no-multi --prompt="monstrous use of lua bro > "',
}

-- local schedule = assert(io.open(arg[1], 'r'))
-- local lines = schedule:read("*all")
-- schedule:close()


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

-- don't call py just yet
local py_get_schedule = coroutine.wrap(function ()
  coroutine.yield(os.execute(cmd.python.get_schedule))
end)

-- only run this if there's no arg[1], aka schedule file
-- the point of this is to send a schedule file to fzf for picking patients.
-- this only runs to set a variable, viz. 'my_file'.
local function gum_prompt()
  local use_today = os.capture(cmd.gum.today, false)
  if use_today == 'yes' then
    local my_file = billing .. os.date("/%m-%d-%Y") .. '.csv'
    print("here's the file we should open:", my_file)
    local my_file_exists = assert(io.read(my_file))
    if my_file_exists == nil then
      print("assert(io.read(^^^)) doesn't exist, would call:", "py_get_schedule()")
      --py_get_schedule()
    end
  elseif use_today == 'no' then
    local candidates = os.capture(cmd.fd, true)
    print('type of candidates', type(candidates))
    candidates:gsub("[\n\r]+", "")
    print('candidates:', candidates)
    os.capture('gum choose ' .. candidates)
    --  echo "one" "two" "three" "four" | xargs gum choose
    -- now get back input in the way that echo 'one' 'two' 'three' does, i.e. to stdout on same line 
    -- local my_file = os.capture('gum choose ' .. candidates)
    -- return my_file
  end
end

-- gum_prompt()

local choice = coroutine.wrap(function ()
  coroutine.yield(os.capture(cmd.fzf))
end) ()

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
return M
