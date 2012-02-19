class CreatePlaceholderWidgets < ActiveRecord::Migration
  def change
    create_table :placeholder_widgets do |t|
      t.integer :widget_id
      t.integer :placeholder_id
      t.integer :position

      t.timestamps
    end
  end
end
