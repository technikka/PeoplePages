class Notification < ApplicationRecord
  belongs_to :friendship

  # how to validate that a foreign key of any kind exists?
  # ^^ example from my like model:
  # validates :comment_id, presence: true, unless: :post_id
  # validates :post_id, presence: true, unless: :comment_id
end
