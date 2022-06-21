class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :current_city
      t.string :hometown
      t.string :workplace
      t.string :websites
      t.string :social_links

      t.timestamps
    end
  end
end
