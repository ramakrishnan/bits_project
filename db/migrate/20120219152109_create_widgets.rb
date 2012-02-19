class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :filename
      t.integer :width
      t.integer :widget_type
      t.text :data
      t.text :style

      t.timestamps
    end
  end
end
