class SearchController < ApplicationController
	def show
		@page = Page.build_by_slug(params[:slug])
		render "public/404"   if @page.blank?
		
	end
end