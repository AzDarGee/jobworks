class AddFieldsToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :tags, :text, array: true, default: []
    add_column :jobs, :salary_range, :string
    add_column :jobs, :start_date, :datetime
    add_column :jobs, :industry, :string
    add_column :jobs, :company_id, :integer
  end
end
