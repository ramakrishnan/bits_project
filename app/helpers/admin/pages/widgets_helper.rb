module Admin::Pages::WidgetsHelper
	def option_tags_for_widgets(available_width)
	options = []
	Widget.where(:width => available_width).each do |widget|
	 options << content_tag(:option, widget.name, 
				 :value => widget.id,
				 "data-width" => widget.width).html_safe 
	end
	options
    end
end
