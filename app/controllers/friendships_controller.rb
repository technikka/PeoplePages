class FriendshipsController < ApplicationController
  # instantiating a friendship creates a one way relationship (a friend request)
  # when a user accepts a friend request a new friendship record is created.
  # a mutual relationship (to be a 'friend') is considered when these two records coexist.

  def index
    @active_friends = current_user.active_friends
    @pending_friends = current_user.pending_friends
  end

  def new
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])

    redirect_to user_path(params[:user_id])
  end

  def create
    if params[:type] == 'accept_request'
      @friend = User.find(params[:requester])
      @friendship = Friendship.create(user_id: current_user.id, friend_id: @friend.id)

      # if accepting from requester's page:
      if request.referer.include?(@friend.id.to_s) &&
         !request.referer.include?('friendships') &&
         !request.referer.include?('notifications')
        redirect_to request.referrer, status: :see_other
      else
        render partial: 'accept_request'
      end
    else
      @friend = User.find(params[:id] || params[:user_id])
      @friendship = Friendship.create(user_id: current_user.id, friend_id: @friend.id)
      render partial: 'cancel_request'
    end
  end

  def destroy
    if params[:type] == 'deny_request'
      friendship = Friendship.find(params[:id])
      @requester = friendship.user
      friendship.destroy

      # if denying request from requester's page:
      if request.referer.include?(@requester.id.to_s) &&
         !request.referer.include?('friendships') &&
         !request.referer.include?('notifications')
        redirect_to request.referrer, status: :see_other
      else
        render partial: 'deny_request'
      end

    elsif params[:type] == 'unfriend'
      @user_friendship = Friendship.find(params[:id])
      @friend_friendship = Friendship.find_by(user_id: params[:friend], friend_id: current_user.id)
      @user_friendship.destroy
      @friend_friendship.destroy
      redirect_to request.referrer, status: :see_other

    else
      @friend = User.find(params[:user_id]) if params[:user_id]
      Friendship.find(params[:id]).destroy
      render partial: 'initiate_request'
    end
  end
end
