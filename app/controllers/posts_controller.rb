class PostsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
before_action :set_post, only: [:edit, :update, :destroy]
before_action :user_prohibition?, only: [:new, :create, :edit, :update, :destroy]

  def index
    result = Post.page(params[:page]).order(created_at: :desc)
    @posts = Kaminari.paginate_array(result).page(params[:page]).per(16)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
    @comments = @post.comments
    if user_signed_in?
      @comment = current_user.comments.new
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_url, flash: {notice: "投稿しました"}
    else
      #renderだとview側の設計の問題でActiveStorageFileNotFoudErrorに引っかかるため暫定対応
      flash[:alert] = '保存に失敗しました'
      redirect_back(fallback_location: root_url)
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
    redirect_to profile_show_user_path(@post.user_id), flash: {notice: "投稿を削除しました"}
  end

  private
    def set_post
      if current_user.admin?
        @post = Post.find(params[:id])
      else
        @post = current_user.posts.find_by(id: params[:id])
      end
    end

    def post_params
      params.require(:post).permit(:image, :body, :user_id)
    end
end
