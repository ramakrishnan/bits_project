class Layout < ActiveRecord::Base
	belongs_to :page
	belongs_to :placeholder
	has_many :placeholder_widgets
	has_many :widgets, :through => :placeholder_widgets
end
