class WidgetType < ActiveRecord::Base
 has_many :widgets
	
	TYPES =	{
		 "Regular" => 1,
		 "Advertisement" => 2,
		 "Video slider" => 3
		}
	
end
