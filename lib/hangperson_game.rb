class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(new_word)
    @word          = new_word
    @guesses       = ""
    @wrong_guesses = ""
  end
    
  
  def guess(guess_letter)
    if guess_letter == nil
      raise ArgumentError, "nil string"
    elsif guess_letter.empty? 
      raise ArgumentError, "Poor formatting"
    elsif ! guess_letter.gsub(/[a-zA-Z]/, "").empty?
      raise ArgumentError, "Poor formatting"
    end
    if @word.include? guess_letter
      if ! @guesses.include? guess_letter
        @guesses += guess_letter
        true
      else
        false
      end
    else
      if ! @wrong_guesses.include? guess_letter
        @wrong_guesses += guess_letter
        true
      else
        false
      end
    end
  end

  def word_with_guesses()
    diffs = (@word.split(//)-@guesses.split(//)).uniq
    tmp = ""
    @word.split(//).each do |c|
      if ! diffs.include? c
        tmp+=c
      else
        tmp+='-'
      end
    end
    tmp
  end

  def check_win_or_lose()
    diffs = (@word.split(//)-@guesses.split(//)).uniq
    if diffs.empty?
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
