#!/usr/bin/env ruby

require "./word-rank"
require "test/unit"

class TestWordScore < Test::Unit::TestCase

  def test_word_one
    ws = WordScore.new("AAAB")
    assert_equal(1,ws.score())
  end

  def test_word_two
    ws = WordScore.new("BAAA")
    assert_equal(4,ws.score())
  end

  def test_word_three
    ws = WordScore.new("ABAB")
    assert_equal(2,ws.score())
  end

  def test_word_four
    ws = WordScore.new("QUESTION")
    assert_equal(24572,ws.score())
  end

  def test_word_five
    ws = WordScore.new("BOOKKEEPER")
    assert_equal(10743,ws.score())
  end

end
