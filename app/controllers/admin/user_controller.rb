class Admin::UserController < ApplicationController
  before_action :authenticate_user!
  before_action :user_admin?

  def index
    @users = User.page(params[:page]).per(50).order(created_at: :desc)
  end

  private
    def user_admin?
      redirect_to root_url unless current_user.admin?
    end
end
