class Widget < ActiveRecord::Base
	has_many :holdings
	has_many :collections
	has_many :placeholders, :through => :holdings
	validates_presence_of :filename, :name, :width, :widget_type
end
