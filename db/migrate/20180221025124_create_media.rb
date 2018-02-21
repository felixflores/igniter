class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.references :mediable, polymorphic: true, index: true
      t.string :type
      t.string :url
      t.string :short_description
      t.text :additional_information

      t.timestamps
    end
  end
end
