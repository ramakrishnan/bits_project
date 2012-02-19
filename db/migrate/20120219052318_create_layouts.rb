class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :page_placeholders do |t|
      t.integer :page_id
      t.integer :placeholder_id
      t.integer :row
      t.integer :column

      t.timestamps
    end
  end
end
