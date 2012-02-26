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
			puts rows.class
			puts "//////////////"
			rows.each do |row, columns|
				puts columns.inspect
				puts columns.class
				columns.each_with_index do |template, index|
					index = index + 1
					@page.placeholders.create(:row => row, :column => index,
						:template_id => template)
				end
			end
		end
		redirect_to :action => new_admin_page_path
	end
	
	def new
		@templates = Template.all
		@page = Page.new
	end
end
