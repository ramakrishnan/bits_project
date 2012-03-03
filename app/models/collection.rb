class Collection < ActiveRecord::Base
	belongs_to :widget
	before_save :form_unique_data
	
	serialize :data, Array
	
	def form_unique_data
		self.data.uniq!
	end
	
	def self.types
		[["Video","Video"]]
	end
end
