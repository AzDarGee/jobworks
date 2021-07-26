class ChangeUrlFieldsInJobs < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :apply_url, :text
    change_column :jobs, :url, :text
  end
end
