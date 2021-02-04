# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(email: 'test@example.com') do |user|
  user.name = "tony"
  user.password = "password"
  user.avatar.attach(io: File.open(Rails.root.join("app/assets/images/icon_user.jpg")),
                    filename: 'default_user_avatar')
end

4.times do |i|
  post = Post.new(
    user_id: 1,
    body: "No#{i+1}. Time goes on. So whatever you’re going to do, do it. Do it now. Don’t wait."
  )
  post.image.attach(io: File.open("app/assets/images/sample#{i+1}.jpg"), filename: "sample#{i+1}.jpg",
                      content_type: 'image/jpg')
  post.save!
end
