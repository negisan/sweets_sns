class UsersController < ApplicationController
  before_action :authenticate_user!

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(5)
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.follower.page(params[:page]).per(5)
  end

end
