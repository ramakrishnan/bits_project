class Language < ActiveRecord::Base
	validates_presence_of :name
	validates_length_of :name, :maximum => 100
	has_and_belongs_to_many :videos
	before_destroy {|language|  
		language.videos.clear
	}		
end
