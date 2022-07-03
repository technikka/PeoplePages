class Post < ApplicationRecord
  belongs_to :user
  validates :body, length: { in: 12..12_000 }
end
