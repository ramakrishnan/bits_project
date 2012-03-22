class Widget < ActiveRecord::Base
	has_many :holdings, :dependent => :destroy
	has_many :collections, :dependent => :destroy
	has_many :placeholders, :through => :holdings
        belongs_to :widget_type, :foreign_key => :widget_type
	serialize :properties, Hash
	
	validates_presence_of :filename, :unless => Proc.new{|w| w.is_advertisement?}  
	validates_length_of :name, :maximum => 255
	validates_presence_of :name, :width, :widget_type
	validate :json_format, :unless => lambda {|widget| widget.new_record? }
		
	FILETYPES = [
		["header", "/widgets/header.html.erb",966],
		["footer", "/widgets/footer.html.erb",966],
		["search", "/widgets/search.html.erb",165],
		["video_player", "/widgets/video_player.html.erb",485],
		["4 item slider", "/widgets/video_slider_485.html.erb",485],
		["header menu", "/widgets/header_menu.html.erb",966],
		["textualize", "/widgets/textualize.html.erb",966],
		["html5video", "/widgets/html5video_subtitle.html.erb",966],
		["home page static content", "/widgets/homepage_content.html.erb",485],
		["news ticker", "/widgets/news_ticker.html.erb",966],
		["Video gallery", "/widgets/video_gallery.html.erb",793]]

	before_save {|widget|
			widget.properties = JSON["#{widget.properties}"] if !widget.new_record?
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
		data = str.split("\n")
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
	:private
	def json_format
		errors.add(:properties,  "not in json format") unless properties_is_json?
	end
	
	def properties_is_json?
    begin
      !!JSON.parse(properties)
    rescue
      false
    end
  end
end
