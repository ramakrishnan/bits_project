class Admin::PagesController < ApplicationController
layout 'admin'
	def create
		
	end
	
	def new
		@templates = Template.all
		Wpage = Pagew.new
	end
end
