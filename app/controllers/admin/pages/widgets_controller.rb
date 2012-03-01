class Admin::Pages::WidgetsController < ApplicationController
	layout "admin"
	
	def index
		@page = Page.includes(:placeholders => [:grid, :holdings,
					 :widgets]).find(params[:page_id])	 
	end
	
	def create
		placeholder = Placeholder.find(params[:placeholder])
		res = placeholder.holdings.create(:widget_id => params[:widget])
		if res.errors.blank?
			flash[:notice] = "Widget added"
		else
			flash[:errors] = res.errors.full_messages.join("<br/>")
		end	
		redirect_to  admin_page_widgets_path(params[:page_id])
	end
end
