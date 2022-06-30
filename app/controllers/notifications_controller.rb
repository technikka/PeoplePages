class NotificationsController < ApplicationController
  def index
    @notifications = User.notifications(current_user)
    @friend_requests = @notifications.select { |n| n.kind_of? Friendship } if @notifications
    binding.pry
  end
end