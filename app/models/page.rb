class Page < ActiveRecord::Base
	has_many :placeholders, :order => "`row`, `column`"
	has_many :grids, :through => :placeholders
	
	def self.build
		Page.includes(:placeholders => [:grid, :holdings,
					 :widgets]).find(1)
	end
end
