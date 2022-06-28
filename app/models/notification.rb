class Notification < ApplicationRecord
  belongs_to :friendship

  # how to validate that a foreign key of any kind exists?
end
