class Category < ActiveRecord::Base
	validates_presence_of :name
	validates_length_of :name, :maximum => 100
	has_and_belongs_to_many :videos
	before_destroy {|category|  
		category.videos.clear
	}	
end
