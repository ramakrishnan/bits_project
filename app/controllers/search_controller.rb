class SearchController < ApplicationController
	def show
		@page = Page.build_by_slug("search")
	  	options = {}
	  	options.merge!(:category => params[:category]) unless params[:category].blank?
	  	options.merge!(:language => params[:language]) unless params[:language].blank?
	  	result = Collection.find_all_for(Video, options )
		@refinements = result.paginate(:page => params[:page], :per_page => 1)
		if @page.blank?
			render "public/404"   
		else
			render :template => "pages/show"
		end
	end
end