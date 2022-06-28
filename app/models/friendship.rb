class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_one :notification, dependent: :destroy

  validates :user_id, presence: true, uniqueness: true
  validates :friend_id, presence: true

  after_create { create_notification }
  before_destroy { notification.destroy }
end
