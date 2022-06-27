class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, presence: true, uniqueness: true
  validates :friend_id, presence: true

  after_save :create_notification
  after_destroy :destroy_notification

  private

  def create_notification
    Notification.create(kind: 'friend_request', user_id: self.friend_id)
  end

  def destroy_notification
    Notification.find_by(user_id: self.friend_id, kind: 'friend_request').destroy
  end

end
