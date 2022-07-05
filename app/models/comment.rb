class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :body, length: { in: 2..1_000 }
end
