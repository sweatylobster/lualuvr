local commands = require('commands')
local prefs = require('preferences')

local choice = commands.bat_to_fzf(prefs.path_to_test_file)
print(choice)

-- local entry = require('csv').to_table(choice)
-- print(entry.name, entry.dos, entry.doctor)

commands.tex(choice)
