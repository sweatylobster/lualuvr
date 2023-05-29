-- read up on load on p.148 of Programming in Lua 4th edition 
-- referenced almost identically by u/uga-rosa
-- https://github.com/uga-rosa
-- https://www.reddit.com/r/lua/comments/sa8tmq/how_to_convert_string_to_table/

M = {}

function M.eval(s)
    return assert(load(s))() -- call the code if it compiles; give descriptive error.
end

function M.str2obj(s)
    return M.eval("return " .. s) -- return whatever output the chunk would produce
end

function M.parse_clargs()
  local final_arg = arg[#arg]
  return M.str2obj(final_arg)
end

return M
