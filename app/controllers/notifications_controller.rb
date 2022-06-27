class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user_id: current_user.id)
    if @notifications
      @friend_requests = @notifications.select { |n| n.kind == 'friend_request' }
    end
  end
end