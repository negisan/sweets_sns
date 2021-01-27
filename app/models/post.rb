class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :image, presence: true, blob: {content_type: :image}
  validates :body, length: {maximum: 200}
end
