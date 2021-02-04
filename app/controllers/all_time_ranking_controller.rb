class AllTimeRankingController < ApplicationController
  def index
    result = Post.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
    @posts = Kaminari.paginate_array(result).page(params[:page]).per(16)
  end
end
