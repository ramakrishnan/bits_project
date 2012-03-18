class AddColumnPropertiesToWidget < ActiveRecord::Migration
  def change
    add_column :widgets, :properties, :text
  end
end
