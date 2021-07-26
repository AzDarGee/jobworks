class RemoveTagsFromJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :tags
  end
end
