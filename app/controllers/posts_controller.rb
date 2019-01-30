class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save

      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def to_favor
    @post = Post.find(params[:id]).favorites.new(token_id: @token_id)

    respond_to do |format|
      if @post.save
        format.js
      else
        format.js
      end
    end
end

  private

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end
end
