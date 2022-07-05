class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :body, length: { in: 12..12_000 }
end
