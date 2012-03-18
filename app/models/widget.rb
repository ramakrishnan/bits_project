class Widget < ActiveRecord::Base
	has_many :holdings, :dependent => :destroy
	has_many :collections, :dependent => :destroy
	has_many :placeholders, :through => :holdings
	
	validates_presence_of :filename, :unless => Proc.new{|w| w.is_advertisement?}  
	validates_length_of :name, :maximum => 255
	validates_presence_of :name, :width, :widget_type
	
		
	FILETYPES = [
		["header", "/widgets/header.html.erb",966],
		["footer", "/widgets/footer.html.erb",966],
		["search", "/widgets/search.html.erb",165],
		["video_player", "/widgets/video_player.html.erb",485],
		["4 item slider", "/widgets/video_slider_485.html.erb",485],
		["home page static content", "/widgets/homepage_content.html.erb",485],
		["Video gallery", "/widgets/video_gallery.html.erb",793]]

	def is_advertisement?
		widget_type == WidgetType::TYPES["Advertisement"]
	end
end
