class VideoController < ApplicationController
	def show
		@page = Page.build_by_slug("video")
		@video = Video.find(params[:id])
		if @page.blank?
			render "public/404"   
		else
			render :template => "pages/show"
		end
	end
end