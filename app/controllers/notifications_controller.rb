class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user_id: current_user.id)

    if @notifications
      @friend_requests = @notifications.select { |n| n.kind == 'friend_request' }

      # find the friendship objects that correspond to friend request notifications.
      @friendships = Friendship.where(friend_id: current_user)
      @friendships.select { |f| f.user_id == current_user.id }
    end
  end
end