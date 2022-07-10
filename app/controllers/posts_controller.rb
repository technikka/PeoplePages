class PostsController < ApplicationController

  def index
    ids = current_user.active_friends.map(&:id)
    ids << current_user.id
    # friend_id indicates a personal post (not for timeline)
    @posts = Post.where(user_id: [ids], friend_id: nil)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.friend_id && @post.save
      redirect_to request.referer
    elsif @post.save
      redirect_to posts_path
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity, alert: 'Problem updating post'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, status: 303, notice: 'Post sucessfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:body, :friend_id)
  end
end
