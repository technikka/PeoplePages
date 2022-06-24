class ChangeColumnNameTypeInNotifications < ActiveRecord::Migration[7.0]
  def change
    rename_column :notifications, :type, :kind
  end
end
