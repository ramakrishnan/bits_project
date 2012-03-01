class CreateWidgetTypes < ActiveRecord::Migration
  def change
    create_table :widget_types do |t|
      t.string :name	

      t.timestamps
    end
  end
end
