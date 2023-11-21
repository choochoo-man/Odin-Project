# use recursion to calculate how many steps to get from any given number to 1.
# if the number is odd, 3n +1
# if the number is even n / 2
def collatz_recursion(n, steps = 0)
  if n == 1
    return steps
  end

  if n.odd?
    n = (3 * n) + 1
    steps += 1
    collatz_recursion(n, steps)
  end

  if n.even?
    n = n / 2 
    steps += 1
    collatz_recursion(n, steps)
  end
end

puts collatz_recursion(7)

