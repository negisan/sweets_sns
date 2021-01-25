class PostsController < ApplicationController
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
      params.require(:post).permit(:post_image, :post_body, :user_id, :post_image)
    end
end
