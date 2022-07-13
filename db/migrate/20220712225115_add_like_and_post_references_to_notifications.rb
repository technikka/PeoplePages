class AddLikeAndPostReferencesToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_reference :notifications, :post, foreign_key: true
    add_reference :notifications, :like, foreign_key: true
  end
end
