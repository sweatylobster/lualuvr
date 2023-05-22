-- page 4
--
function fact(n)
  if n == 0 then
    return 1
  elseif n <= 0 then
    return "Are there negative factorials now?"
  else
    return n * fact(n-1)
  end
end

print("Enter a number...")
a = io.read("*n")
print(fact(a))


--notes
--nice little recursive function
