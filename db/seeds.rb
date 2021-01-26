# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(email: 'test@example.com') do |user|
  user.name = "tony",
  user.password = "password"
end

post = Post.create!(
  user_id: 1,
  body: 'First post'
  )
post.image.attach(io: File.open(Rails.root.join("app/assets/images/sample.jpg")),
                  filename: 'sample..jpg')