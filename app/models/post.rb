class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :likes
  has_many :liked_users, :through => :likes, :source => :user

  validates :image, presence: true, blob: {content_type: :image}
  validates :body, length: {maximum: 200}
end
