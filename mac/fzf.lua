local mac = {
  fd = "fd -t f .csv -d 1 --search-path=/Users/maxdehoyos/code/aguila/billing | fzf --delimiter='/' --with-nth=7 --tac"
}

local my_file = arg[1]

local fzf = "bat {my_file} -p -f | fzf --reverse --prompt='monstrous' --ansi --margin=2 --padding=2 --header-lines=1 --no-multi"
fzf = fzf:gsub("{my_file}", my_file)
print(fzf)

local function capture(cmd)
  local choice = assert(io.popen(cmd, 'r'))
  local s = assert(choice:read("*all"))
  choice:close()
  return s
end

print("This is coming from in Lua", capture(fzf))
