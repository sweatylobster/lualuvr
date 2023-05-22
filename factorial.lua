local function factorial(x)
  local sum = 1
    for i=2,x do
      sum = sum * i
  end
  return sum
end

local function combinations(n, r)
  local numerator = factorial(n)
  local difference = factorial(n-r)
  local denominator = factorial(r) * difference
  return numerator // denominator
end

print("The number of combinations for 5 objects taken in 3 at a time is:", combinations(5, 3))
print("The factorial of 7 is: ", factorial(7))
