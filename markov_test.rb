require 'minitest/autorun'
require 'minitest/pride'
require_relative 'markov'

class MarkovTest < MiniTest::Test

  def test_it_counts_how_each_a_word_follows_a_given_word
    marky = Markov.new("Little Mary had a little lamb, little lamb, little lamb")
    word_list = {"mary" => 1, "lamb," => 2, "lamb" => 1}
    assert_equal word_list, marky.words("little")
  end

  def test_it_chooses_probability_according_to_occurence
    marky = Markov.new("Little Mary had a little lamb, little lamb, little lamb")
    assert_equal ["mary", "lamb,", "lamb,", "lamb"], marky.word_frequency("little")
  end

  def test_it_generates_a_random_word_from_probability
    marky = Markov.new("Little Mary had a little lamb, little lamb, little lamb")
    assert_equal "lamb,", marky.random_word("little")
  end

  def test_it_appends_word_with_its_following_word
    marky = Markov.new("Little Mary had a little lamb, little lamb, little lamb")
    marky.new_sentence = "little"
    assert_equal "little mary", marky.append_random_word("little")
  end

  def test_it_make_a_sentence_as_lengthy_as_the_given_sentence
    marky = Markov.new("Little Mary had a little lamb, little lamb, little lamb")
    assert_equal 10, marky.build_new_sentence.split(" ").count
  end
end
