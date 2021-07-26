class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :text
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :social_media_links, :jsonb
  end
end
