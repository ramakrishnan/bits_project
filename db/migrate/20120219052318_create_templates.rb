class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.integer :width
      t.string :color

      t.timestamps
    end
  end
end
