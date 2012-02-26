class Admin::PagesController < ApplicationController
layout 'admin'
	def create
		rows = params[:row]
		if rows.length == 0
			flash[:notice] = "Invalid templates for page"	
			render :action => "new" and return
		end		
		@page = Page.new(params[:page])
		if @page.save
			rows.each do |row, columns|
				columns.each_with_index do |template, index|
					index = index + 1
					@page.placeholders.create(:row => row, :column => index,
						:template_id => template)
				end
			end
			redirect_to :action => new_admin_page_path	
		else
			flash[:message] = "Please check the following fields"
			render :action => "new"
		end
	end
	
	def index
		@pages = Page.all
	end
	
	def new
		@templates = Template.all
		@page = Page.new
	end
end
