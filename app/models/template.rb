class Template < ActiveRecord::Base
	has_many :placeholders
	has_many :pages, :through => :placeholders
end
