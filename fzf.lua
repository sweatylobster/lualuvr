local commands = require('commands')
local prefs = require('preferences')

-- local test_choice = "4,Max de Hoyos,04-02-1995,Mehrdad Shademan,05-23-2023"

local function surround(s, char)
  return char .. s .. char
end

local choice = commands.bat_to_fzf(prefs.path_to_test_file)

print(surround(choice, "'"))

-- local entry = csv.to_table(choice)
-- print(entry.name, entry.dos, entry.doctor)

os.execute('lualatex attempt.tex --jobname="WOWZA" ' .. surround(choice, "'"))
