-- coroutine.create(FUNCTION) returns --> thread
local ll = coroutine.create(function (a)
  -- the thread yields *a value* to the caller like so.
  print('co-body', a)
  return coroutine.yield(a + 5)
  -- any yield, be it in a function or in the coroutine's body, will return a value to the main scope.
  -- when the coroutine is resumed, it will continue from the line following the most recent coroutine.yield(x).
end)

assert(type(ll) == 'thread', 'll is not a created coroutine')

-- this is how we execute the thread.
print('main', coroutine.resume(ll, 5))
-- this returns the value 8 to the 
print('main', coroutine.resume(ll, 8))
print('main', coroutine.resume(ll, 7))
