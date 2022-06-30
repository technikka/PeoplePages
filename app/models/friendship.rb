class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_one :notification, dependent: :destroy

  validates :user_id, presence: true, uniqueness: { scope: :friend_id, message: 'identical record exists' }
  validates :friend_id, presence: true, uniqueness: { scope: :user_id, message: 'identical record exists' }

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

  before_destroy { notification.destroy if notification }

  private

  # determines if the creation of self is a friend request acceptance
  def mutual_relationship?
    friend.friends.include?(user)
  end
end
