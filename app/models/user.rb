class User < ApplicationRecord
  require 'faker'

  before_create :set_default_user_avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, :through => :likes, :source => :post
  has_many :comments, dependent: :destroy


  def self.guest
    int = rand(100) + 1
    User.create!(
      email: "guest#{int}@example.com",
      password: 'password',
      introduction: Faker::Movies::HarryPotter.quote
    )
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def set_default_user_avatar
    if !self.avatar.attached?
      self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'icon_user.jpg')),
                              filename: 'default-user-avatar.jpg', content_type: 'image/jpg')
    end
  end
end
