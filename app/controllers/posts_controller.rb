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
    @posts = if params[:favorites]
               Post.joins(:favorites).where('favorites.token_id = ?', @token_id)
             else
               Post.all
           end
  end

  def show
    @post = Post.find(params[:id])
    @related_posts = get_related_posts(@post.id,@post.tags)
  end

  def add_favorite
    @post = Post.find(params[:id]).favorites.where(token_id: @token_id).first_or_create!

    respond_to do |format|
      format.js { @icon_id = params[:id] }
    end
end

  def remove_favorite
    Post.find(params[:id]).favorites.find_by(token_id: @token_id).destroy

    respond_to do |format|
      format.js { @icon_id = params[:id] }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end

  def get_related_posts(source_id,tags)
    tags_ids = []
    tags.each do |tag|
      tags_ids << tag.id
    end
    tags.ids
    Post.joins(:tags).where('posts.id <> ? AND tags.id IN (?)',source_id,tags_ids).distinct.limit(6)
  end
end
