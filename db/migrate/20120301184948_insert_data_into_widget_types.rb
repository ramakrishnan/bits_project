class InsertDataIntoWidgetTypes < ActiveRecord::Migration
  def up
  	WidgetType.create(:id => 1, :name => "Regular")
  	WidgetType.create(:id => 2, :name => "Advertisement")
  	WidgetType.create(:id => 3, :name => "Video slider")
  end

  def down
  	WidgetType.delete_all
  end
end
