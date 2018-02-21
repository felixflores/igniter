class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.datetime :start_date
      t.string :location

      t.timestamps
    end
  end
end
