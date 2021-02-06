# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

3.times do |i|
  User.find_or_create_by(email: "test#{i+1}@example.com") do |user|
    user.name = Faker::Name.name
    user.password = "password"
    user.introduction = Faker::JapaneseMedia::StudioGhibli.quote
    user.avatar.attach(io: File.open(Rails.root.join("app/assets/images/user_avatar#{i+1}.jpg")),
    filename: 'sample_user_avatar')
  end
end



4.times do |i|
  post = Post.new(
    user_id: 1,
    body: "Time goes on. So whatever you’re going to do, do it. Do it now. Don’t wait."
  )
  post.image.attach(io: File.open("app/assets/images/sample#{i+1}.jpg"), filename: "sample#{i+1}.jpg",
                      content_type: 'image/jpg')
  post.save!
end

4.times do |i|
  post = Post.new(
    user_id: 2,
    body: "Time goes on. So whatever you’re going to do, do it. Do it now. Don’t wait."
  )
  post.image.attach(io: File.open("app/assets/images/sample#{i+5}.jpg"), filename: "sample#{i+4}.jpg",
                      content_type: 'image/jpg')
  post.save!
end

4.times do |i|
  post = Post.new(
    user_id: 3,
    body: "Time goes on. So whatever you’re going to do, do it. Do it now. Don’t wait."
  )
  post.image.attach(io: File.open("app/assets/images/sample#{i+9}.jpg"), filename: "sample#{i+4}.jpg",
                      content_type: 'image/jpg')
  post.save!
end



4.times do |i|
  Like.create(
    user_id: 1, post_id: i+7
  )
  Like.create(
    user_id: 2, post_id: i+1
  )
  Like.create(
    user_id: 3, post_id: i+3
  )
end


6.times do |i|
  Comment.create(
    user_id: 1, post_id: i+1, content: Faker::Movies::StarWars.quote
  )
  Comment.create(
    user_id: 2, post_id: i+1, content: Faker::Movies::StarWars.quote
  )
  Comment.create(
    user_id: 3, post_id: i+1, content: Faker::Movies::StarWars.quote
  )
end

