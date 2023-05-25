M = {}

local first  = { '1', '21', '31'  }
local second = { '2', '22'  }
local third  = { '3', '23'  }
local trouble = {first, second, third}
local replacement = {'st', 'nd', 'rd'}

local function remove_leading_zeroes(date_string)
  local r = date_string:match("0(%d)")
  return r or date_string
end

-- some_day : string, number, or nil -> today
function M.DayWithSuffix(some_day)
  if some_day == nil then
    some_day = os.date("%d")
  end
  local day = tostring(some_day)
  day = remove_leading_zeroes(day)
  -- day = day:gsub("0(%d)", "%d")
  for i, sub in ipairs(trouble) do
    for _, x in ipairs(sub) do
      if x == day then
        return day .. replacement[i]
      end
    end
  end
  return day .. 'th'
end

local function suffix_dat(some_day)
  if some_day == nil then
    some_day = os.date("%d")
  end
  local day = tostring(some_day)
  day = remove_leading_zeroes(some_day)
  for i, sub in ipairs(trouble) do
    for _, x in ipairs(sub) do
      if x == day then
        return day .. replacement[i]
      end
    end
  end
  return day .. 'th'
end

function M.PresentDateString(t)
  local time_table = os.time(t)
  local weekday_and_month = os.date("%A, %B ", time_table)
  local suffixed_day = M.DayWithSuffix(os.date("%d", time_table))
  local year = os.date(", %Y", time_table)
  local synthesis = weekday_and_month .. suffixed_day .. year
  return synthesis
end

local function format_date_string(t)
  local time_table = os.time(t)
  local weekday_and_month = os.date("%A, %B ", time_table)
  local suffixed_day = suffix_dat(os.date("%d", time_table))
  local year = os.date(", %Y", time_table)
  local synthesis = weekday_and_month .. suffixed_day .. year
  return synthesis
end

local some_day = {month = '4', day = '2', year = '1995'}
print(M.PresentDateString(some_day))

function M.Tabulate(date_string)
  local t = {}
  t.day = date_string:match("%d%d%d%d%-?/?%d%d%-?/?(%d%d)") or date_string:match("%d%d%-?/?(%d%d)%-?/?%d%d%d%d")
  t.month = date_string:match("%d%d%d%d%-?/?(%d%d)%-?/?%d%d") or date_string:match("(%d%d)%-?/?%d%d%-?/?%d%d%d%d")
  t.year = date_string:match("%d%d%d%d")
  return t
end

local function alt_tabulate(date_string)
  local t = {}
  local pats = {
    -- i really mean one or the other separator; / or -
    "%d%d%d%d%-?/?(%d%d)%-?/?(%d%d)",
    "(%d%d)%-?/?(%d%d)%-?/?%d%d%d%d",
  }
  date_string = tostring(date_string)
  local m1, d1 = date_string:match(pats[1])
  local m2, d2 = date_string:match(pats[2])
  t.day = d1 or d2
  t.month = m1 or m2
  t.year = date_string:match("%d%d%d%d")
  return t
end

local function covert(date_string)
  local date_table = alt_tabulate(date_string)
  return format_date_string(date_table)
end

function M.Overt(date_string)
  return covert(date_string)
end

print('covert:', covert("04/02/1995"))
print('overt:', M.Overt("04/02/1995"))

return M
