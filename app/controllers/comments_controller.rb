class CommentsController < ApplicationController
  before_action :find_commentable, :get_parent


  def create

    @comment = @commentable.comments.new(comment_params)

      if @comment.save
        increment_comments_counter
        respond_to do |format|
          format.js { render "create", :locals => { post: @parent, new_comment: @comment } }
        end
      else
        flash[:danger] = "You can't leave the comment in blank"
        redirect_back fallback_location: root_path
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

    def increment_comments_counter
      @parent.increment! :comments_counter
    end

    def get_parent
      @parent = @commentable
      @parent = @parent.commentable while @parent.is_a? Comment
    end
end
