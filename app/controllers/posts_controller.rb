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

  def add_favorite
    @post = Post.find(params[:id]).favorites.where(token_id: @token_id).first_or_create!

    respond_to do |format|
        format.js { @icon_id = params[:id]}
    end
end

def remove_favorite

  Post.find(params[:id]).favorites.find_by(token_id:@token_id).destroy



  respond_to do |format|
      format.js { @icon_id = params[:id]}
  end

end


  private

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end
end
