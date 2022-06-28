class AddActionIdToNotification < ActiveRecord::Migration[7.0]
  def change
    add_reference :notifications, :friendship, foreign_key: true
  end
end
