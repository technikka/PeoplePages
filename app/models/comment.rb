class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, dependent: :destroy
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :body, length: { in: 2..1_000 }

  default_scope { order(created_at: :ASC) }
end
