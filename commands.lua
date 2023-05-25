local prefs = require('preferences')
local capture = require('capture')
return {
  -- we can eventually turn these into bat_opts for customizability, but i want proof of concept now.
  bat = "bat -p -f " .. prefs.path_to_test_file,
  fzf = 'fzf --reverse --prompt="monstrous use of lua bro > " --ansi --margin=2 --padding=2 --header-lines=1 --no-multi',
  fd = {
    csv = 'fd -t f .csv -d 1 --search-path=' .. prefs.billing_path
  },
  gum = {
    today = 'gum input --placeholder="You wanna print a lien from today\'s schedule?"',
    past = 'gum input --header="Which day do you wanna print a lien for, then?"',
  schedule = 'python ' .. prefs.billing_path ..  'get_schedule.py',
  },
  bat_to_fzf = function (file)
    local a = {
      "bat -p -f " .. file,
      'fzf --reverse --prompt="commands.lua baby > " --ansi --header-lines=1'
    }
    local bat_pipe = table.concat(a, " | ")
    return capture.to_string(bat_pipe)
  end,
  -- Use fd to return a list of .csv files in a given directory.
  fd_csv = function(directory)
    local dir = directory or prefs.billing_path
    local fd = 'fd -t f .csv -d 1 --search-path=' .. dir
    return capture.to_string(fd)
  end,
  fd_file = function(f, dir)
    local cmd = {"fd -t ", f, "-d 1", '--search-path=', dir}
    local query = table.concat(cmd)
    return capture.to_string(query)
  end,
  gum_today = function ()
    local day = capture.to_string('gum choose "yes" "no" --header="You wanna use today\'s schedule?"')
    if day == 'yes' then
      local path = prefs.billing_path .. os.date("%m-%d-%Y") .. '.csv'
      local file = assert(io.input(path))
      return file
    elseif day == 'no' then
      -- get back a table of csv candidates
      local candidates = capture.to_table('fd -t f csv -d 1 --search-path=' .. prefs.billing_path)
      local csv_files = table.concat(candidates, ' ')
      local file = capture.to_string('gum choose ' .. csv_files)
      return file
    end
  end,
  get_schedule = function ()
    return os.execute("python " .. prefs.billing_path .. 'get_schedule.py')
  end,
  latex = function (table_as_string)
    local result = io.popen('python '.. prefs.luaforms_path .. 'pylualatex.py ' .. table_as_string , 'r')
    return result
  end
}
