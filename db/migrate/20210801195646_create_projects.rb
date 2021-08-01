class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string      :title
      t.text        :description
      t.datetime    :start_date
      t.datetime    :end_date
      t.belongs_to  :user
      t.float       :price


      t.timestamps
    end
  end
end
