class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :comment
  validates :user_id, presence: true
  validates :comment_id, presence: true, unless: :post_id
  validates :post_id, presence: true, unless: :comment_id
end
