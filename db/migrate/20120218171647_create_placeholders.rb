class CreatePlaceholders < ActiveRecord::Migration
  def change
    create_table :placeholders do |t|
      t.integer :row
      t.integer :column
      t.string :color
      t.integer :width
      t.integer :page_id

      t.timestamps
    end
  end
end
