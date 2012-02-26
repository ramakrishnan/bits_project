class Holding < ActiveRecord::Base
	belongs_to :widget
	belongs_to :placeholder
end
