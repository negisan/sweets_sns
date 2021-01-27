FactoryBot.define do
  factory :post do
    body {'test'}

    after(:build) do |post|
      post.image.attach(
        io: File.open('spec/fixtures/sample.jpg'),
        filename: 'sample.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
