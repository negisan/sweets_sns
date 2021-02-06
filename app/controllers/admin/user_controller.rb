class Admin::UserController < ApplicationController
  before_action :authenticate_user!
  before_action :user_admin?

  def index
  end

  private
    def user_admin?
      redirect_to root_url unless current_user.admin?
    end
end
