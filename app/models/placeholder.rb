class Placeholder < ActiveRecord::Base
	belongs_to :page
	belongs_to :template
	has_many :holdings
	has_many :widgets, :through => :holdings
end
