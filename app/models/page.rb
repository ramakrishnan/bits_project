class Page < ActiveRecord::Base
	has_many :placeholders, :order => "`row`, `column`", :dependent => :destroy
	has_many :grids, :through => :placeholders
	
	before_destroy {|video|  
		video.categories.clear
		video.languages.clear
	}
	validates_presence_of :name, :slug
	validates_uniqueness_of :slug
	
	
	def self.build_by_id(id)
	  build_association.find(id)
	end
	
	def self.build_by_slug(slug)
	  build_association.find_by_slug(slug)	
	end
	
	def self.build_association
		includes(:placeholders => [:grid, :holdings,
					 :widgets])
	end
end
