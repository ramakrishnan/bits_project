class Admin::Pages::WidgetsController < ApplicationController
	layout "admin"
	
	def index
		@page = Page.build_by_id(params[:page_id])
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
	
	def update
	  current_holding = Holding.find_by_widget_id_and_placeholder_id(params[:id], params[:placeholder_id])
		if params[:direction] == "up"
		  current_holding.move_up
		elsif params[:direction] == "down" 
			current_holding.move_down
		end
	  redirect_to  admin_page_widgets_path(params[:page_id])	
	end
	
	def destroy
	  current_holding = Holding.find_by_widget_id_and_placeholder_id(params[:id], params[:placeholder_id])		
	  current_holding.destroy
	  redirect_to  admin_page_widgets_path(params[:page_id])
	end
end
