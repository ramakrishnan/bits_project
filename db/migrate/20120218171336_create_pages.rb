class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :slug
      t.text :style
      t.boolean :is_live

      t.timestamps
    end
  end
end
