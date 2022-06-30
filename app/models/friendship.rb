class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_one :notification, dependent: :destroy

  validates :user_id, presence: true
  validates :friend_id, presence: true

  after_create do
    if mutual_relationship?
      # find friendship for corresponding request
      friendship = Friendship.find_by(user_id: friend.id, friend_id: user.id)
      # delete the notification for request
      friendship.notification.destroy
    else
      create_notification
    end
  end

  before_destroy { notification.destroy }

  private

  # determines if the creation of self is a friend request acceptance
  def mutual_relationship?
    friend.friends.include?(user)
  end
end
