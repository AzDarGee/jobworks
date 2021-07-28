class AddIndexToSearchableJobs < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    execute <<-SQL
      ALTER TABLE jobs
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
        setweight(to_tsvector('english', coalesce(description,'')), 'B')
      ) STORED;
    SQL
    add_index :jobs, :searchable, using: :gin, algorithm: :concurrently
  end
end
