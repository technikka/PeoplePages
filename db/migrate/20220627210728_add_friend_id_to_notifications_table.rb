class AddFriendIdToNotificationsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :friend_id, :integer
  end
end
