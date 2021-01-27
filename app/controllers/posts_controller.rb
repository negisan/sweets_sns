class PostsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]
before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_url, flash: {notice: "投稿しました"}
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post), flash: {notice: "投稿を更新しました"}
    else
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to root_url, flash: {notice: "投稿を削除しました"}
  end

  private
    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit(:image, :body, :user_id)
    end
end
