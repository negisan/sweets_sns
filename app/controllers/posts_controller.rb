class PostsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def update
  end

  private
    def post_params
      params.require(:post).permit(:image, :body, :user_id)
    end
end
