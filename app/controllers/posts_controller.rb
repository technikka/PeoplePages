class PostsController < ApplicationController

  def index
    ids = current_user.active_friends.map(&:id)
    ids << current_user.id
    @posts = Post.where(user_id: [ids])
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, status: 303, notice: 'Post sucessfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
