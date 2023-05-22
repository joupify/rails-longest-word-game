require 'json'
require 'open-uri'

class GamesController < ApplicationController

  VOWELS = %w(A E I O U Y)
  def new
    @letters = Array.new(5) { ('A'..'Z').to_a.sample }
    @letters += Array.new(5) { VOWELS.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    # The word can’t be built out of the original grid
    condition1 = @word.size <= @letters.size
    # The word is valid according to the grid, but is not a valid English word
    condition2 = word_valid?(@word) && !english_word?(@word)
    # The word is valid according to the grid and is an English word
    condition3 = word_valid?(@word) && english_word?(@word)

    if condition1 && condition2
      @result = 'The word is valid according to the grid, but it is not a valid English word.'
    elsif condition1 && condition3
      @result = 'The word is valid according to the grid and it is an English word.'
    else
      @result = "The word can't be built out of the original grid."
    end
  end

  private

  def word_can_be_built?(word, letters)
    word_chars = word.upcase.chars
    letters_chars = letters.chars
    word_chars.all? { |char| letters_chars.include?(char) && letters_chars.delete_at(letters_chars.index(char)) }

    # valid = true
    # word_chars.each do |char|
    #   if letters_chars.include?(char)
    #     letters_chars.delete_at(letters_chars.index(char))
    #   else
    #     valid = false
    #     break
    #   end
    # end
    # valid
  end

  def word_valid?(word)
    word_can_be_built?(@word, @letters) && english_word?(word)
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url)
    result = JSON.parse(response.read)
    result['found']
  end
end
