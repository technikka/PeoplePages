class CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.includes(:comments).comments
  end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(body: comment_params[:body], user_id: current_user.id)
    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referer }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
