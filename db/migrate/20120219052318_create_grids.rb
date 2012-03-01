class CreateGrids < ActiveRecord::Migration
  def change
    create_table :grids do |t|
      t.string :name
      t.integer :width
      t.string :color

      t.timestamps
    end
  end
end
