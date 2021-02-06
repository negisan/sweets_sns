FactoryBot.define do
  factory :comment do
    content { "test comment" }
    user { nil }
    post { nil }
  end
end
