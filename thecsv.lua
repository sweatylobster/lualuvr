local M = {}

local function get_csv_fields(csv_line)
  local t = {}
  for i in string.gmatch(csv_line, ",?([%d%-/%a%s]+)") do
    table.insert(t, i)
  end
  return t
end

-- turn it into a table
function M.CsvToTable(csv_line)
  local a = {}
  local keys = {'line', 'name', 'dob', 'doctor', 'dos'}
  local fields = get_csv_fields(csv_line)
  for i, x in ipairs(fields) do
    if i == 1 then end
    a[keys[i]] = x
  end
  return a
end


-- this is so fkn jank lmao
function M.CsvToString(csv_line)
  local a = {}
  table.insert(a, "{ ")
  local keys = {'line', 'name', 'dob', 'doctor', 'dos'}
  local fields = get_csv_fields(csv_line)
  for i, v in ipairs(fields) do
    table.insert(a, keys[i] .. "=" .. '"' .. v .. '"' .. ',')
  end
  table.insert(a, " }")
  return table.concat(a)
end

return M
