class LikesController < ApplicationController
  # shows all likes on a specific post or comment
  def index; end

  def create
    @post = params[:post] if params[:type] == 'post'
    @comment = params[:comment] if params[:type] == 'comment'

    foreign_key = { post_id: @post, comment_id: @comment }
    @like = current_user.likes.build(foreign_key)
    @like.save!
    resource = if @post
                 Post.find(@post)
               else
                 Comment.find(@comment)
               end
    render partial: 'unlike', locals: { resource: resource }
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    @comment = @like.comment
    resource = @post || @comment
    @like.destroy
    render partial: 'like', locals: { resource: resource }
  end
end
