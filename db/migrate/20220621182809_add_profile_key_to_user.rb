class AddProfileKeyToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :profiles, foreign_key: true
  end
end
