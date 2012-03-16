class Video < ActiveRecord::Base
	has_and_belongs_to_many :languages
	has_and_belongs_to_many :categories
	
	scope :join_category, lambda { |cat_id| joins(:categories).where(:categories_videos => {:category_id => cat_id }) }
	
	scope :join_language, lambda { |lan_id| joins(:languages).where(:languages_videos => {:language_id => lan_id }) }
end
