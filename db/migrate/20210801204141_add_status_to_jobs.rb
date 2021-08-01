class AddStatusToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :status, :string
    add_column :jobs, :num_employees, :integer
  end
end
