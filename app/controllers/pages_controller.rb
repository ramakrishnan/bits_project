class PagesController < ApplicationController
	def show
		render :text => params[:slug]
	end
end