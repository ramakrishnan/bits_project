class Page < ActiveRecord::Base
	has_many :placeholders
	has_many :grids, :through => :placeholders
end
