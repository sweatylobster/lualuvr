local cmd = require('commands')

local date = cmd.gum_today()

local choice = cmd.bat_to_fzf(date)

print(choice)
