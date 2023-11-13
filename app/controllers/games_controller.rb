require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letters = ('a'..'z').to_a
    @random_letters = Array.new(10) { letters.sample }
  end

  def score
    word = params[:input_word]
    grid = params[:grid]
    @is_included = word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
    grid_array = grid.split(' ')

    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    @is_a_word = json['found']

    if @is_included == true && @is_a_word == true
      @result = "Congratulations! <b>#{word.upcase}</b> is a valid English word!"
    elsif @is_included == true && @is_a_word == false
      @result = "Sorry but <b>#{word.upcase}</b> does not seem to be a valid English word..."
    else
      @result = "Sorry but <b>#{word.upcase}</b> can't be built out of #{grid_array.join(',').upcase}"
    end
  end
end
