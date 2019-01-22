class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)

      if @comment.save
        redirect_to @post
      else

        flash[:notice] = "You can't leave the comment in blank"
        redirect_to @post
      end

  end


    private

    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
