require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  array_of_films_for_character = []

   response_hash["results"].each do |person|
    if person["name"] == character_name
      array_of_films_for_character << person["films"]
    end
  end

  array_of_url_data = []

  array_of_films_for_character[0].each do |url|
    array_of_url_data << JSON.parse(RestClient.get(url))
  end

  array_of_url_data
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end


def print_movies(films)
  films.each do |film|
    puts "*" * 20
    puts film["title"]
    puts " "
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end