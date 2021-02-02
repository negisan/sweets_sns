FactoryBot.define do

  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"password"}
    password_confirmation {"password"}

    after(:build) do |user|
      user.avatar.attach(
        io: File.open('spec/fixtures/icon_user.jpg'),
        filename: 'user_avatar.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
