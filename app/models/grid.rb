class Grid < ActiveRecord::Base
	has_many :placeholders
	has_many :pages, :through => :placeholders
	validates_presence_of :width, :name, :color
	validates_uniqueness_of :width, :name, :color	
end
