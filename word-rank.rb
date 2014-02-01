#!/usr/bin/env ruby

class Fixnum
  def factorial
    f = 1
    for i in 1..self
      f *= i
    end
    return f
  end

  alias_method :!, :factorial
end

class WordScore
  def initialize(word)
    @word = word
    alph = @word.split("").sort
    @counts = []
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
      @counts << count
    end
    @alph = alph.uniq
  end

  def score(word=@word)
    before = 0
    for i in (0...word.size)
      ind = @alph.index(word[i])
      prior = 0
      for j in (0...ind)
        possible = (word.size - i - 1).factorial
        for k in (0...@counts.size)
          if j == k
            possible /= (@counts[k] - 1).factorial
          else
            possible /= (@counts[k]).factorial
          end
        end
        prior += possible
      end
      before += prior
      @counts[ind] -= 1
      if @counts[ind] == 0
        @counts.delete_at(ind)
        @alph.delete_at(ind)
      end
    end
    
    return before + 1
  end
end

input = $stdin.gets.chomp

word_score = WordScore.new(input)
puts word_score.score
