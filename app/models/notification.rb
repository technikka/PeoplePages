class Notification < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :kind, presence: true
end
