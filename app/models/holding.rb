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
		previous_holding = self.class.where("placeholder_id = #{self.placeholder_id} and  position < #{self.position}").first
		if previous_holding
			current_position = self.position
			previous_position = previous_holding.position
			self.update_attributes(:position => previous_position)
			previous_holding.update_attributes(:position => current_position)
	    end
	end
	
	def move_down
		next_holding = self.class.where("placeholder_id = #{self.placeholder_id} and position > #{self.position}").first
		if next_holding
			current_position = self.position
			next_position = next_holding.position
			self.update_attributes(:position => next_position)
			next_holding.update_attributes(:position => current_position)
	    end
	end
end
