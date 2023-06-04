local f = assert(io.open("testoutfile.txt", "r"))
local s = f:read("*a")

print(s:match("Output written on .+%.pdf"))
