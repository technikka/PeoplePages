class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])

    redirect_to user_path(params[:user_id])
  end

  def create
    @user = User.find(params[:id])
    @friendship = Friendship.new(user_id: current_user.id, friend_id: @user.id)

    if @friendship.save
      render partial: 'cancel_request'
    else
      redirect_to @user, alert: 'Something went wrong requesting friend'
    end
  end

  def destroy
    @user = User.find(params[:id])
    Friendship.find_by(user_id: current_user.id, friend_id: @user.id).destroy
    render partial: 'initiate_request'
  end
end
