-- Surround a "string" with a given *character*.
local function surround(s, char)
  return char .. s .. char
end

local function parse_choices(choices)
  for i, v in pairs(choices) do
    choices[i] = surround(choices[i], '"')
  end
  return table.concat(choices, " ")
end

-- --header="hello"
-- {header="hello"}
local function parse_opts(opts)
  if type(opts) == "string" then return opts end
  local results = {}
  for k, v in pairs(opts) do
    --no-limit
    local s
    if type(k) == "number" then
      local match = string.match(v, "(--[%w-]+)")
      print(match)
      s = match or ("--" .. v)
    else
      s = "--" .. k .. "=" .. surround(v, '"')
    end
    table.insert(results, s)
  end
  return table.concat(results, " ")
end



local function test_choice_parsing()
  local test = {"jim", "ron"}
  return parse_choices(test)
end

-- passes!
-- print('Can we parse choices?', test_choice_parsing())

local function test_option_parsing()
  local test = {header="hello", placeholder='can you do both?', "--no-limit"}
  return parse_opts(test)
end

-- passes too!
-- print('And can we parse options passed in as a table?', test_option_parsing())


local gum = {
    choose = function (choices, opts)
      local cmd = table.concat({"gum choose", parse_choices(choices), parse_opts(opts)}, " ")
      local f = assert(io.popen(cmd), 'r')
      local s = f:read("*a")
      return s
    end
  }

print(gum.choose({"me", "you"}, {header="THIS TOWN ET CETERA!", "--no-limit"}))
