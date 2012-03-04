class Widget < ActiveRecord::Base
	has_many :holdings
	has_many :collections
	has_many :placeholders, :through => :holdings
	
	validates_presence_of :filename, :unless => Proc.new{|w| w.is_advertisement?}  
	validates_presence_of :name, :width, :widget_type
	
		
	FILETYPES = [["header", "/widgets/header.html.erb"],
		["footer", "/widgets/footer.html.erb"],
		["search", "/widgets/search.html.erb"],
		["video_player", "/widgets/video_player.html.erb"],
		["4 item slider", "/widgets/video_slider_485.html.erb"],
		["home page static content", "/widgets/homepage_content.html.erb"]]

	def is_advertisement?
		widget_type == WidgetType::TYPES["Advertisement"]
	end
end
