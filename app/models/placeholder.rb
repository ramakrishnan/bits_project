class Placeholder < ActiveRecord::Base
	belongs_to :page
	belongs_to :grid
	has_many :holdings, :order => "position", :dependent => :destroy
	has_many :widgets, :through => :holdings
	
	validates_presence_of :grid_id, :page_id, :row, :column
end
