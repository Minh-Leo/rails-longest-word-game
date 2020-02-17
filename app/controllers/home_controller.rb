require 'open-uri'
require 'json'

class HomeController < ApplicationController
  def new
    random_letters(8)
    @start_time = Time.now.to_i
  end

  def score
    # raise
    @attempt = params[:word]

    if check_english_word(@attempt)
      return @score = [0, 'not in the grid'] unless check_include_in

      @score = [give_score(@word_hash, params[:start_time]), 'Congratulation']
    else
      @score = [0, 'not an english word']
    end
  end

  # Check stuffs
  def random_letters(num)
    @letters = Array.new(num) { ('A'..'Z').to_a.sample }
  end

  def convert_to_h(arr)
    arr.map { |c| [c, c] }.to_h
  end

  def check_english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    @data = JSON.parse(open(url).read)
    @word = @data['word'].upcase
    @data['found']
  end

  def check_include_in
    letters_hash = convert_to_h(params[:letters].split)
    @word_hash = convert_to_h(@word.chars)
    (@word_hash.to_a - letters_hash.to_a).empty?
  end

  def give_score(hash, start_time)
    @end_time = Time.now.to_i
    @result = @end_time - start_time.to_i
    @points = 0 + hash.size
    @total = (@points.to_f / @result) + 1
  end
end
