class Markov
  attr_accessor :new_sentence
  def initialize(file)
    @new_sentence = ''
    @sentence = []
    book = File.readlines(file)
    book.each do |line|
      @sentence << line.delete("\\").split(" ")
    end
    @sentence.flatten!
  end

  def words(word)
    words_following_word = Hash.new(0)
    @sentence.each_with_index do |entry, index|
      words_following_word[@sentence[index + 1]] += 1 if entry == word
    end
    words_following_word
  end

  def word_frequency(word)
    following_words = words(word)
    frequent_words = []
    following_words.each do |key, value|
      value.times do
        frequent_words << key
      end
    end
    frequent_words
  end

  def random_word(word)
    word_frequency(word).sample
  end

  def append_random_word(word)
    @new_sentence << " " + random_word(word)
  end

  def build_new_sentence
    @new_sentence << @sentence.sample
    100.times do
      append_random_word(@new_sentence.split(" ").last)
    end
    @new_sentence
  end
end

p Markov.new("bgae.txt").build_new_sentence
puts "\n"+ "\n"
p Markov.new("ms.txt").build_new_sentence
puts "\n"+ "\n"
p Markov.new("ht.txt").build_new_sentence
puts "\n"+ "\n"
