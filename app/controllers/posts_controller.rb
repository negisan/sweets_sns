class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.new(post_params)
  end

  def update
  end

  private
    def post_params
      params.require(:post).permit(:post_image, :post_body, :user_id)
    end
end
