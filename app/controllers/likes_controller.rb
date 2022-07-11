class LikesController < ApplicationController
  # shows all likes on a specific post or comment
  def index; end

  def create
    @post = params[:like_post] if params[:like_post]
    @comment = params[:like_comment] if params[:like_comment]

    foreign_key = { post_id: @post, comment_id: @comment }
    @like = current_user.likes.build(foreign_key)
    binding.pry
  end

  def destroy; end
end
