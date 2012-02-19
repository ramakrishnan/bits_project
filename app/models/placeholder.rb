class Placeholder < ActiveRecord::Base
	belongs_to :page
	belongs_to :template
	has_many :placeholder_widgets
	has_many :widgets, :through => :placeholder_widgets
end
