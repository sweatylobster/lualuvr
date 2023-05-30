co = coroutine.create(function (a)
 coroutine.yield(a + 4)
end)

print(coroutine.resume(co, 2))
print(coroutine.status(co))
-- why doesn't this return 9?
print(coroutine.resume(co, 5))

joe = coroutine.create(function ()
  print('joe', coroutine.yield())
end)

coroutine.resume(joe)
-- need the line above to make this one return extra args.
coroutine.resume(joe, 42, 1, 7, 9)
-- this be the behavior.
-- rationale? needs to return true if not expecting args.
-- this one works bc expecting args.

dilettante = coroutine.create(function (a, b)
  for i=a,b do
    print(i + 100)
  end
end)

coroutine.resume(dilettante, 1, 8)
-- not much point baking for loops into coroutines B/
-- but here's roberto's example
fornicator = coroutine.create(function ()
  for i=1,10 do
    print("co", i)
    coroutine.yield()
  end
end)

coroutine.resume(fornicator, "doesn't matter what i put here")
coroutine.resume(fornicator, "or here?")
coroutine.resume(fornicator, "maybe it does now")
coroutine.resume(fornicator, "and now too?")
coroutine.resume(fornicator, "no never mind")
coroutine.resume(fornicator, "we're not printing extra args")
coroutine.resume(fornicator, "how does the extra args example work above?")
coroutine.resume(fornicator, "namely line 16?")

-- BRUH
-- I SEE
-- I WAS MISSING COROUTINE.YIELD THE WHOLE TIME
-- of course -- you might need one for loop 
