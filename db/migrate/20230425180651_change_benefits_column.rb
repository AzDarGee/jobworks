class ChangeBenefitsColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :jobs, :benefits
    add_column :jobs, :benefits, :text, array: true, default: []
  end
end
