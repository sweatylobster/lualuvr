local prefs = require('preferences')
local capture = require('capture')
local csv = require('csv')
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
  schedule = prefs.py_interpreter .. prefs.billing_path ..  'get_schedule.py',
  },

  bat_to_fzf = function (file)
    local a = {
      "bat -p -f " .. file,
      'fzf --reverse --prompt="commands.lua +18 baby > " --ansi --header-lines=1 --header="Press CTRL-L for alien. The patient\'s alien."'
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
      assert(io.input(path), "It appears we don't have the schedule for today.")
      return path
    elseif day == 'no' then
      -- get back a table of csv candidates
      local candidates = capture.to_table('fd -t f csv -d 1 --search-path=' .. prefs.billing_path)
      local csv_files = table.concat(candidates, ' ')
      local file = capture.to_string('gum choose ' .. csv_files)
      return file
    end
  end,

  get_schedule = function ()
    return os.execute(prefs.py_interpreter .. prefs.billing_path .. 'get_schedule.py')
  end,

  latex = function (table_as_string)
    local result = io.popen(prefs.py_interpreter.. prefs.luaforms_path .. 'pylualatex.py ' .. table_as_string , 'r')
    return result
  end,

  -- Compile a lualatex document for a patient.
  tex = function (choice)
    local function surround(s, char)
      return char .. s .. char
    end
    local patient = csv.to_table(choice)
    local args = {
      'lualatex',
      '--jobname=' .. surround(patient.name, '"'),
      '--output-directory=' .. prefs.output_directory,
      prefs.tex_path .. 'test.tex',
      surround(csv.to_string(choice), "'"),
    }
    local result = table.concat(args, " ")
    -- print(result)
    local output = assert(io.popen(result, 'r'))
    local status = output:read("*a")
    local exit = status:match("Output written on .+%.pdf")
    print(exit)
    return exit
  end

}
