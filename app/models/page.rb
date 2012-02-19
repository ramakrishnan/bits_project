class Page < ActiveRecord::Base
	has_many :layouts
	has_many :placeholders, :through => :layouts
end
