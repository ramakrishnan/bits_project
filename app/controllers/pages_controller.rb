class PagesController < ApplicationController

	def show
		@page = Page.build_by_slug(params[:slug])
	end
end