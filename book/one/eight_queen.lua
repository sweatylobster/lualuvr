-- in the eight queen puzzle:
-- each queen occupies one of the eight rows.
-- a solution means no queen can attack any other
-- a is the array of already added queens; their positions
-- n is the number of queens already added
-- c is the column.

N = 8 -- board size

-- check whether position (n, c) is free from attacks
function isplaceok(a, n, c)
  for i = 1, n - 1 do           -- for each queen already placed
    if (a[i] == c) or          -- either it's in the same column
      (a[i] - i == c - n) or    -- along a left-diagonal
      (a[i] + i == c + n) then  -- along a right-diagonal
    return false
    end
  end
  return true                   -- can't be attacked
end

-- print a board
function printsolution (a)
  for i = 1, N do -- for each row in the board 
    for j = 1, N do -- and for each column along that row
      -- write "X" or "-" plus a space
      io.write(a[i] == j and "X" or "-", " ")  -- wow, that's pretty cool! `and` prefers the right-hand value, so only the "X" is printed.
    end
    io.write("\n") -- go to the next row.
  end
  io.write("\n")
end

function addqueen(a, n)
  if n > N then    -- all queens have been placed?
    printsolution(a)
  else -- try and place n-th queen
    for c = 1, N do
      if isplaceok(a, n, c) then
        a[n] = c  -- place n-th queen at column 'c'
        addqueen(a, n + 1)
      end
    end
  end
end

-- solution table and first queen
addqueen({}, 1)
