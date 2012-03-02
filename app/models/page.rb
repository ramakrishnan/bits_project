class Page < ActiveRecord::Base
	has_many :placeholders, :order => "`row`, `column`"
	has_many :grids, :through => :placeholders
	validates_presence_of :name, :slug
	validates_uniqueness_of :slug
end
