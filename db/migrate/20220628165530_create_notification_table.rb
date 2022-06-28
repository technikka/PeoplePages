class CreateNotificationTable < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :kind
      t.timestamps
    end
  end
end
