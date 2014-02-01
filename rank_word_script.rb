#!/usr/bin/env ruby

require "./word-rank"

input = $stdin.gets.chomp

word_score = WordScore.new(input)
puts word_score.score
