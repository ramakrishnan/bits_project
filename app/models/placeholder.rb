class Placeholder < ActiveRecord::Base
	has_many :layouts
	has_many :pages, :through => :layouts
end
