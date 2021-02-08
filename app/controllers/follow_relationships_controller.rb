class FollowRelationshipsController < ApplicationController

  def create
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.follow(@user)
    redirect_to profile_show_user_path(@user)
  end

  def destroy
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.unfollow(@user)
    redirect_to profile_show_user_path(@user)
  end

end
