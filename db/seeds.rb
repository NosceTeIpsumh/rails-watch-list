require 'open-uri'
require 'json'

URL = "https://tmdb.lewagon.com/movie/top_rated"
POSTER_URL = "https://image.tmdb.org/t/p/original"

puts "Cleaning database"
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Fetching movies"
movies_serialized = URI.open(URL).read
movies = JSON.parse(movies_serialized)["results"]

puts "Creating movies"
movies.each do |movie|
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "#{POSTER_URL}#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

puts "Created 20 movies."
