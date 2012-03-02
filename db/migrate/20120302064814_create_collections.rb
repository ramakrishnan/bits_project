class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :type
      t.text :data
      t.integer :widget_id

      t.timestamps
    end
  end
end
