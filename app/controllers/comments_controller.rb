class CommentsController < ApplicationController
  before_action :find_commentable

  def create

    @comment = @commentable.comments.new(comment_params)

      if @comment.save
        redirect_to @post
      else
        flash[:notice] = "You can't leave the comment in blank"
        redirect_to @post
      end

  end


    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
    end
end
