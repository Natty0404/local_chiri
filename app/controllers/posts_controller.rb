class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @user = current_user
    @posts = @user.posts
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to request.referer
      flash[:notice] = "投稿が完了しました"
    else
      @post = Post.new
      @user = current_user
      @posts = @user.posts
      render 'new'
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def index
    @posts = Post.page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(2)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
      flash[:notice] = "更新が完了しました"
    else
      render 'edit'
      flash[:alert] = "更新に失敗しました"
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@user.id)
    flash[:notice] = "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :address, :latitude, :longitude)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end

end
