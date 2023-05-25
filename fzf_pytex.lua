local cmds = require('commands')
local prefs = require('preferences')
local csv = require('csv')

local choice = cmds.bat_to_fzf(prefs.path_to_test_file)

local table_as_string = csv.repr(choice)

print(table_as_string)

-- local test = cmds.latex(table_as_string)
