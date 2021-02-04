class WeeklyRankingController < ApplicationController
  def index
    to  = Time.current.at_end_of_day
    from    = (to - 6.day).at_beginning_of_day
    posts_weekly = Post.where(created_at: from...to)
    result = posts_weekly.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
    @posts = Kaminari.paginate_array(result).page(params[:page]).per(16)
  end
end
