class Users::ProfileController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(12).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(user_profile_params)
      redirect_to profile_show_user_path(@user), notice: 'プロフィールを更新しました'
    else
      render profile_edit_user_path(@user)
    end
  end

  private
    def user_profile_params
      params.require(:user).permit(:avatar, :name, :introduction)
    end
end
