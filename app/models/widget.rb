class Widget < ActiveRecord::Base
	has_many :holdings
	has_many :placeholders, :through => :holdings
end
