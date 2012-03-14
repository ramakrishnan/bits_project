class Video < ActiveRecord::Base
	has_and_belongs_to_many :languages
	has_and_belongs_to_many :categories
end
