# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Destroying bookmarks. Destroying lists. Destroying movies."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)["results"]


movies.each do |movie|
  new_movie = Movie.create(
    title: movie["original_title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie[:poster_path]}",
    rating: movie["vote_average"]
  )

  puts "New movie created: #{new_movie.title}"
end

puts "Initiating a new list"
10.times do
  new_list = List.create(
    name: Faker::Nation.nationality
  )

  puts "List created: #{new_list.name}"

  puts "Initiating 5 to 10 bookmarks"
  rand(5..10).times do
    new_bookmark = Bookmark.new(
      comment: Faker::Quotes::Shakespeare.hamlet_quote
    )

    new_bookmark.list = new_list
    new_bookmark.movie = Movie.all.sample
    puts "Bookmark validation: #{new_bookmark.valid?}"
    new_bookmark.save

    puts "New bookmark #{new_bookmark.movie} on #{new_bookmark.list}"
  end

end

puts "Finished seeding."

# 100.times do
#   movie = Movie.create(
#     title: ,
#     overview: ,
#     poster_url: ,
#     rating: ,
#   )
# end

# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)

# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)

# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)

# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

# List.create(name: "A test list")

# my_bookmark = Bookmark.new
# my_bookmark.comment = "A test comment"
# my_bookmark.movie = Movie.last
# my_bookmark.list = List.last
# my_bookmark.save
