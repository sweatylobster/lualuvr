-- This module always returns a date.
-- This date corresponds to a `%m-%d-%Y.csv` file.
-- This simple date is returned in another file, so the chosen schedule is loaded.
-- Therefore, this file prompts the user to choose a schedule file.
-- The purpose of this to choose patients from.

local capture = require('capture')
local prefs = require('preferences')

-- Sets defaults fd and fzf.
local cmd = {
  fd = "fd -t f .csv -d 1 --search-path=" .. prefs.billing_path,
  fzf = "| fzf --delimiter='/' --with-nth=7 --tac",
}

-- local a = {"cow", "sow", "monstrow"}
local b = capture.to_table(cmd.fd)

local s = table.concat(b, " ")
local n = table.concat(b, "\n")

local function gum_choose(choices)
  local c = assert(io.popen('gum choose --header="Choose a day, cutie!" ' .. choices, 'r'))
  local gum_table = c:read('a')
  return gum_table
end

print("This is the day you chose!", gum_choose(s))
