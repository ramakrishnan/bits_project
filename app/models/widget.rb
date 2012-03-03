class Widget < ActiveRecord::Base
	has_many :holdings
	has_many :collections
	has_many :placeholders, :through => :holdings
	
	validates_presence_of :filename, :if => Proc.new{|w| w.widget_type != WidgetType::TYPES["Advertisement"] }  
	validates_presence_of :name, :width, :widget_type
end
