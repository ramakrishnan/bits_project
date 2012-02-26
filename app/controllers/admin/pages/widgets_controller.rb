class Admin::Pages::WidgetsController < ApplicationController
	layout "admin"
	
	def index
		@page = Page.includes(:placeholders => [:holdings, :widgets]).find(params[:page_id])
	end
end
