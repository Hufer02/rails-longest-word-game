require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample}
    @letters
  end


  def score
    @letters = params[:letters].split
    @answer = (params[:answer] || "").upcase
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    raw_json = URI.open(url).read
    @result = JSON.parse(raw_json)
    @included = included?(@answer, @letters)

  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

end
