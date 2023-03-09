# Initial long way
def fibs(n)
  result = []
  fib = 0
  n.times do
    if result.size == 0
      result << fib
    elsif result.size == 1
      result << fib + 1
    elsif result.size >= 2
      result << result[-1] + result[-2]
    end
  end
  result
end

p fibs(8)
# [0, 1, 1, 2, 3, 5, 8, 13]

# Shortened version
def fibs2(n)
  fib = [0, 1]
  (n - 2).times do
    fib << fib[-1] + fib[-2]
  end
  fib
end

p fibs2(8)
# [0, 1, 1, 2, 3, 5, 8, 13]

# Recursive Fib

def fibs_rec(n, fib = [0, 1])
  return fib[0...n] if n <= fib.length

  fib << fib[-2] + fib[-1]
  fibs_rec(n, fib)
end

p fibs_rec(8)
# [0, 1, 1, 2, 3, 5, 8, 13]