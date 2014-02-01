#!/usr/bin/env ruby

# Add a factorial function to the Fixnum class
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

# A class for scoring words within a given alphabet.
class WordScore
  # An instance of the word score class initializes it's alphabet
  # based off a candidate word
  def initialize(word)
    @word = word
    alph = @word.split("").sort

    # Count the number of occurences of each letter of the alphabet.
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

  # Find the rank of a word in the ordered list of possible words from
  # the alphabet. Note that the word passed isn't validated currently.
  def score(word=@word)
    before = 0
    alph = @alph.dup
    counts = @counts.dup

    # For each position in the word find the number of words that are
    # before word being ranked given the prior letters.
    for i in (0...word.size)
      ind = alph.index(word[i])
      prior = 0

      # Count possible words starting with earlier letters in the alphabet
      for j in (0...ind)
        # Possible words ignoring letter repeats
        possible = (word.size - i - 1).factorial
        # Remove number of ways to reorganize each letter
        for k in (0...counts.size)
          if j == k
            possible /= (counts[k] - 1).factorial
          else
            possible /= (counts[k]).factorial
          end
        end
        prior += possible
      end
      before += prior

      # Adjust the alphabet to remove the consumed letter
      counts[ind] -= 1
      if counts[ind] == 0
        counts.delete_at(ind)
        alph.delete_at(ind)
      end
    end

    # Add one to the number of prior words to get the rank
    return before + 1
  end
end

input = $stdin.gets.chomp

word_score = WordScore.new(input)
puts word_score.score
