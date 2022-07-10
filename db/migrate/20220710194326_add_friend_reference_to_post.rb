class AddFriendReferenceToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :friend_id, :integer
  end
end
