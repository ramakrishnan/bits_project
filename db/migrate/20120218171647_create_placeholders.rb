class CreatePlaceholders < ActiveRecord::Migration
  def change
    create_table :placeholders do |t|
      t.string :color
      t.string :name
      t.integer :width

      t.timestamps
    end
  end
end
