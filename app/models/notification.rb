class Notification < ApplicationRecord
  belongs_to :friendship, optional: true
  belongs_to :like, optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
end
