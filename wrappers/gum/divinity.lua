local gum = require('gum')

local div = gum.choose({"cow", "devil"}, {header="divinity", "--no-limit"})

for i, v in ipairs(div) do
  print(i, v)
end

gum.spin("lualatex /Users/maxdehoyos/code/aguila/forms/luaforms/cowabunga.tex", {title="YEEHAW"})
