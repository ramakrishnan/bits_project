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
	
	def self.find_all_for(model,options={})
		if options.blank?
			return model
		else
		  	refinements = model.join_category(options[:category]) unless options[:category].blank?
		  	if !options[:language].blank?
		  		if refinements
					refinements = refinements.join_language(options[:language])
				else
		  			refinements = model.join_language(options[:language])
				end
			end
		end
		refinements		
	end
end
