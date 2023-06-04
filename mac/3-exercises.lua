print(.0e12)        -- infinitely precise 0.0
-- print(e12)         -- no number before the e. the period is an unexpected symbol.
-- print(0.0e)         -- no number *after* the e.
print(0x12)         -- 18 in hex, baby. 0x1 is 1. 0xf is 15. then the next place would be 0x10, for 16. add two and you have 18.
-- print(0xABFG)       -- malformed bc of G -- not a hex number, would be a hep number though tbh
print(0xA)          -- 11 in hex.
-- print(FFFF)         -- nil. this is a name.
print(0xFFFFFFFF)   -- 4294967295, but this one is the essence of hex. 0xf = 15. 0x10 = 16. 0x1f = 31, and 0x20 = 32.
-- 0xfff is 16^3 -1. So for the above example, there are 8 f's in 0xffffffff. 
-- 0xffffffff = 4294967295; 16^8 -1 = 4294967295. Just like DNA being a tertiary semantide -- 4 ^ 3 = 64.
-- print(0x)           -- malformed. 0x, and what?
print(0x1P10)       -- 0x1 is one. P10 duplicates it 10 times, which is 1024. (512, 256, 128, 64, 32, 16, 8, 4, 2)
print(0.1e1)        -- .1 * 10 = 1. It's one. e doesn't mean exponent! it's scientific notation.
print(0x0.1p1)      -- it's the same as two above, just the p (duplicator) can be lowercase.

print([[
In summary:
Floats:
e needs a number before and after it.

Hex stuff.
0x5p4 duplicates 5 4 times.
You can only use p with hex numbers.
0x000000 will never increment the hex.
0x1000 is 16 ^ 3, and three zeroes follow.
]])
