require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @letters = params[:letters]
    @input = params[:name]
    @included = included?(@letters, @input)
    @english = english?(@input)
  end

  def included?(letters_array, input)
    input.chars.all? { |char| letters_array.include? char } ? true : false
  end

  def english?(input)
    url = open("https://wagon-dictionary.herokuapp.com/#{input}")
    json_response = JSON.parse(url.read)
    json_response["found"]
  end
end
