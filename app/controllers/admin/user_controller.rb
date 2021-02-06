class Admin::UserController < ApplicationController
  before_action :authenticate_user!
  before_action :user_admin?

  def index
    @users = User.page(params[:page]).per(50).order(created_at: :desc)
  end

  def update
    user = User.find(params[:id])
    if user.update(prohibition: true)
      redirect_back(fallback_location: admin_users_path)
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.update(prohibition: false)
      redirect_back(fallback_location: admin_users_path)
    end
  end

  private
    def user_admin?
      redirect_to root_url unless current_user.admin?
    end
end
