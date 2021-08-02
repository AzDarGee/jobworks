class AddBenefitsToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :benefits, :text
  end
end
