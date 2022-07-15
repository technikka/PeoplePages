class RemoveNameFromProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :name
  end
end
