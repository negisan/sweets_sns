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

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'FollowRelationship', dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'FollowRelationship', dependent: :destroy
  has_many :follower, through: :follower_relationships


  def following?(other_user)
    self.followings.include?(other_user)
  end

  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end

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
