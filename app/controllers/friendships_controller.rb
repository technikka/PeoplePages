class FriendshipsController < ApplicationController
  # instantiating a friendship creates a one way relationship (a friend request)
  # when a user accepts a friend request a new friendship record is created
  # a mutual relationship (to be a 'friend') is considered when these two records coexist.

  def new
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])

    redirect_to user_path(params[:user_id])
  end

  def create
    # @user necessary when initiating a request
    @user = User.find(params[:id]) if params[:id]
    @friendship = Friendship.create(user_id: current_user.id, friend_id: @user.id)

    if params[:type] == 'accept_request'
      render 'notifications/index' 
    else
      render partial: 'cancel_request'
    end
  end

  def destroy
    if params[:type] == 'deny_request'
      Friendship.find(params[:id]).destroy
      render 'notifications/index'
    else
      # @user necessary when cancelling a request
      @user = User.find(params[:id]) if params[:id]

      @friendship = Friendship.find_by(user_id: current_user.id, friend_id: @user.id)
      @friendship.destroy
      render partial: 'initiate_request'
    end
  end
end
