class RemoveKindFromNotifications < ActiveRecord::Migration[7.0]
  def change
    remove_column :notifications, :kind, :string
  end
end
