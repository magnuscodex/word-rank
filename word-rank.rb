#!/usr/bin/env ruby

input = $stdin.gets.chomp

def factorial(n)
  f = 1
  for i in 1..n
    f *= i
  end
  return f
end

alph = input.split("").sort
counts = []
i = 0
while i < alph.size
  k = i + 1
  char = alph[i]
  count = 1
  while char == alph[k]
    count += 1
    k += 1
  end
  i = k
  counts << count
end
alph = alph.uniq

puts counts.join(",")
puts alph.join(",")

possible = factorial(input.size)
for e in counts
  next if e == 1
  possible /= factorial(e)
end

puts possible

before = 0
for i in (0...input.size)
  ind = alph.index(input[i])
  prior = 0
  for j in (0...ind)
    possible = factorial(input.size - i - 1)
    for k in (0...counts.size)
      if j == k
        possible /= factorial(counts[k] - 1)
      else
        possible /= factorial(counts[k])
      end
    end
    prior += possible
  end
  before += prior
  counts[ind] -= 1
  if counts[ind] == 0
    counts.delete_at(ind)
    alph.delete_at(ind)
  end
end

puts before + 1
