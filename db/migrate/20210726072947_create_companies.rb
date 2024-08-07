class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.boolean :isPublic
      t.text :website
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :description
      t.belongs_to :user

      t.timestamps
    end
  end
end
