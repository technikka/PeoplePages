class LikesController < ApplicationController
  # shows all likes on a specific post or comment
  def index
    klass = params[:resource][:type].constantize
    resource = klass.find(params[:resource][:id])
    @likes = resource.likes
  end

  def create
    klass = params[:resource][:type]
    column = "#{klass.downcase}_id".to_sym
    foreign_key = { column => params[:resource][:id] }

    @like = current_user.likes.build(foreign_key)
    @like.save!

    resource = klass.constantize.find(params[:resource][:id])
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
