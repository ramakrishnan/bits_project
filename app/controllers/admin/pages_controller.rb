class Admin::PagesController < ApplicationController
layout 'admin'
	def create
		
	end
	
	def new
		@templates = Template.all
		@page = Page.new
	end
end
