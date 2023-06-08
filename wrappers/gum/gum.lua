M = {}

local function surround(s, char)
  return char .. s .. char
end


local function parse_choices(choices)
  for k, v in pairs(choices) do
    choices[k] = surround(v, '"')
  end
  return table.concat(choices, " ")
end

-- print(parse_choices({"john", "matthew"}))

local function switch(s)
  local is_good = s:match("%-%-[%a-]+")
  local fix = "--" .. s
  return is_good or fix
end

-- print(switch("--no-limit"))
-- print(switch("no-limit"))
--
local function parse_opts(opts)
  local a = {}
  if opts == nil then return nil end
  for k, v in pairs(opts) do
    -- --no-limit
    if type(k) == "number" then
      table.insert(a, switch(v))
    else
      -- --header="wow"
      local result = string.format('--%s="%s"', k, v)
      table.insert(a, result)
    end
  end
  return table.concat(a, " ")
end

-- print(parse_opts({header="none", "no-limit"}))

M = {
  choose = function (choices, opts)
    local a = {}
    local cmd = table.concat({"gum choose", parse_choices(choices), parse_opts(opts)}, " ")
    local f = assert(io.popen(cmd, "r"))
    for l in f:lines() do
      table.insert(a, l)
    end
    return a
  end,
  spin = function (cmd, opts)
    local cow = table.concat({"gum spin", cmd, parse_opts(opts)}, " ")
    os.execute(cow)
  end,
}

return M
