class NotificationsController < ApplicationController
  def index
    @friend_requests = User.friend_requests(current_user)
    @profile_posts = User.profile_posts(current_user)
    @comments = User.comments(current_user)
    @likes = User.likes(current_user)
  end
end
