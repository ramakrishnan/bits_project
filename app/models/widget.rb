class Widget < ActiveRecord::Base
	has_many :holdings
	has_many :collections
	has_many :placeholders, :through => :holdings
	
	validates_presence_of :filename, :unless => Proc.new{|w| w.is_advertisement?}  
	validates_presence_of :name, :width, :widget_type
	
	def is_advertisement?
		widget_type == WidgetType::TYPES["Advertisement"]
	end
end
