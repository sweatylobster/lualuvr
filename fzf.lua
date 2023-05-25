local csv = require('csv')
local commands = require('commands')
local capture = require('capture')
local prefs = require('preferences')
local ps = require('ps')

-- bat default file into fzf with default options
local myfzf = commands.bat .. " | " .. commands.fzf

-- local choice = capture.to_string(myfzf)

-- local choice = commands.bat_to_fzf(prefs.path_to_test_file)
--
local choice = "4,Max de Hoyos,04-02-1995,Mehrdad Shademan,05-23-2023"

-- local entry = csv.to_table(choice)

-- print(entry.name, entry.dos, entry.doctor)
os.execute('lualatex attempt.tex --jobname="WOWZA" ' .. choice)
