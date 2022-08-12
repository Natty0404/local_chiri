class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "ユーザー名"
      @users = User.search(params[:word])
    else
      @posts = Post.search(params[:word])
    end
  end

end