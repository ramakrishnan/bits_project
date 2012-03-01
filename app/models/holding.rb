class Holding < ActiveRecord::Base
	belongs_to :widget
	belongs_to :placeholder
	validates_uniqueness_of :widget_id, :scope => :placeholder_id,
		:message => "already taken"
	validates_presence_of :widget_id, :placeholder_id
	before_save :validate_widget_width
	after_create :set_position
	
	def validate_widget_width
		if self.widget.width != self.placeholder.grid.width
			errors.add(:widget, "do not fit under the selected placeholder")
		end
	end
	
	def set_position
		self.position = self.id
		self.save
	end
	
	def move_up
	end
	
	def move_down
	end
end
