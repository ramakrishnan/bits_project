class Page < ActiveRecord::Base
	has_many :placeholders
	has_many :templates, :through => :placeholders
end
