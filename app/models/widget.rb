class Widget < ActiveRecord::Base
	has_many :placeholder_widgets
	has_many :placeholders, :through => :placeholder_widgets
end
