# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Destroying all photos in Cloudinary..."
List.all.each do |list|
  list.photo.purge
end

puts "Destroying bookmarks... \n Destroying lists... \n Destroying movies..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)["results"]


movies.each do |movie|
  new_movie = Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie[:poster_path]}",
    rating: movie['vote_average']
  )

  puts "New movie created: #{new_movie.title}"
end

puts 'Initiating a new list'
3.times do
  new_list = List.create(
    name: Faker::Nation.nationality
  )

  random_image = URI.open('https://picsum.photos/1200/800')
  new_list.photo.attach(io: random_image, filename: rand(1...5000).to_s, content_type: 'image/jpg')

  new_list.save

  puts '----------------------------------------'
  puts "List created: #{new_list.name}"
  puts '----------------------------------------'
  puts "Initiating 5 to 10 bookmarks for #{new_list.name}"
  puts '----------------------------------------'
  rand(5..10).times do
    new_bookmark = Bookmark.new(
      comment: Faker::Quotes::Shakespeare.hamlet_quote
    )

    new_bookmark.list = new_list
    new_bookmark.movie = Movie.all.sample
    puts "Bookmark validation: #{new_bookmark.valid?}"
    new_bookmark.save
  end
  puts 'Attempted bookmark saves. Will not be added if unvalid. ✅'

end

puts 'Finished seeding.'
