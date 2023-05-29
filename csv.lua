local M = {}

local function get_csv_fields(csv_line)
  local t = {}
  for i in string.gmatch(csv_line, ",?([%d%-/%a%s]+)") do
    table.insert(t, i)
  end
  return t
end

-- turn it into a table
function M.to_table(csv_line)
  local a = {}
  local keys = {'line', 'name', 'dob', 'doctor', 'dos'}
  local fields = get_csv_fields(csv_line)
  for i, x in ipairs(fields) do
    if i == 1 then end
    a[keys[i]] = x
  end
  return a
end


function M.to_string(csv_line)
  local a = {}
  table.insert(a, "{ ")
  local keys = {'line', 'name', 'dob', 'doctor', 'dos'}
  local fields = get_csv_fields(csv_line)
  for i, v in ipairs(fields) do
    table.insert(a, keys[i] .. "=" .. '"' .. v .. '"' .. ',')
  end
  table.insert(a, " }")
  local s = table.concat(a)
  s = s:gsub(", }", ' }')
  return s
end

return M
