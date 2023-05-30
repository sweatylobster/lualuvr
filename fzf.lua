local commands = require('commands')
local prefs = require('preferences')

-- this can change!
local file = prefs.path_to_test_file

local choice = commands.bat_to_fzf(file)
-- print(choice)

commands.tex(choice)

-- https://www.lua.org/pil/21.2.html
-- we can use the complete aka stream model but it's a bit much
-- we just want to iterate through the table of lines
-- remove the line in question
-- and write back to the file (or another file)
-- local function purge_line(line_in_question, file_in_question)
--   local f = assert(io.open(file_in_question, 'r'))
--   local s = f:read("*all")
--   f:close()
--   local maybe = s:gsub(line_in_question, "")  -- remove the appropriate line
--   io.write(maybe)
--   -- io.output(file_in_question):write(s)-- write back
-- end

-- commands.sed(choice, file)
