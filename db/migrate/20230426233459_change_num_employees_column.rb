class ChangeNumEmployeesColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :jobs, :num_employees
    add_column :jobs, :num_employees, :string
  end
end
