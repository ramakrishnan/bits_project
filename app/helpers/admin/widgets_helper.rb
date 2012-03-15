module Admin::WidgetsHelper
	def option_tags_for_filetypes
	options = []	
	Widget::FILETYPES.each do |opt|
		options << content_tag(:option, opt[0], 
			:value => opt[1],
			"data-width" => opt[2])
	 end
	 options
	end
end