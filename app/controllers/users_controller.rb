class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(12).order(created_at: :desc)
  end
end
