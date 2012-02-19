class PlaceholderWidgets < ActiveRecord::Base
	belongs_to :widget
	belongs_to :placeholder
	has_many :placeholder_widgets
	has_many :widgets, :through => :placeholder_widgets
end
