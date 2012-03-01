class CreatePlaceholders < ActiveRecord::Migration
  def change
    create_table :placeholders do |t|
      t.integer :page_id	
      t.integer :grid_id
      t.integer :row
      t.integer :column

      t.timestamps
    end
  end
end
