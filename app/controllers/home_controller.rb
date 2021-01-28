class HomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc).limit(4)
    posts_likes_desc = Post.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
    @posts_likes_weekly = posts_likes_desc.first(4)

    #@posts_likes_weekly = Post.includes(:liked_users).find(Like.group(:user_id).order('count(user_id) desc').limit(4).pluck(:user_id))
  end
end
