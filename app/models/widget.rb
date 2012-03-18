class Widget < ActiveRecord::Base
	has_many :holdings, :dependent => :destroy
	has_many :collections, :dependent => :destroy
	has_many :placeholders, :through => :holdings
	serialize :properties, Hash
	
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

	before_save {|widget|
		puts "==" * 20
		puts widget.properties.inspect
		widget.properties = JSON["#{widget.properties}"]
	}
	def is_advertisement?
		widget_type == WidgetType::TYPES["Advertisement"]
	end
	
	#FIXME
	# I dont know why I did this
	def read_properties
		str = properties.to_json
		str = str.gsub("}", "\n}")
		str = str.gsub("},", "},\n")
		str = str.gsub("{", "{\n")
		str = str.gsub(",\"", ",\n\"")
		data = str.split()
		indent = 0
		res = []
		data.each do |line|
			if indent > 1
				res << ("\t") * (indent -1) + line	
			else
				res <<  line	
			end
			 if line.include?("{") 
				 indent = indent + 1
			elsif  line.include?("}")
				 indent = indent - 1
			 end
			
		end
		res.join("\n")
	end
end
