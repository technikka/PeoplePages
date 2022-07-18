class Notification < ApplicationRecord
  belongs_to :friendship, optional: true
  belongs_to :like, optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  validates :friendship_id, presence: true, unless: :like_id || :post_id
  validates :like_id, presence: true, unless: :friendship_id || :post_id
  validates :post_id, presence: true, unless: :friendship_id || :like_id
end
