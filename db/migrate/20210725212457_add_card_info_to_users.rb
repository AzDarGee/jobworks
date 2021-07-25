class AddCardInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column  :users, :stripe_id, :string
    add_column :users, :card_brand, :string
    add_column :users, :card_last4, :string
    add_column :users, :card_expiry_month, :string
    add_column :users, :card_expiry_year, :string
    add_column :users, :card_expires, :string
    add_column :users, :username, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :string
    add_column :users, :is_admin, :boolean
  end
end
