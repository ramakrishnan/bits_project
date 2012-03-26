class Admin::PagesController < ApplicationController
layout 'admin'
	def create
		rows = params[:row]
		if rows.length == 0
			flash[:notice] = "Invalid templates for page"	
			render :action => "new" and return
		end		
		@page = Page.new(params[:page])
		Page.transaction do
		 if @page.save
			rows.each do |row, columns|
				columns.each_with_index do |grid, index|
					index = index + 1
					@page.placeholders.create(:row => row, :column => index,
						:grid_id => grid)
				end
			end
		 else			
			flash[:message] = "Please check the following fields"	
			@grids = Grid.all			
			render :action => "new"		 
		 end			
		end




	end
	
	def edit
		@page = Page.find(params[:id])
	end
	
	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])
			redirect_to admin_pages_path
		else
			render :action => "edit"
		end
	end
	
	def index
		@pages = Page.all
	end
	
	def new
		@grids = Grid.all
		@page = Page.new
	end
	
	def destroy
		Page.destroy(params[:id])
		redirect_to admin_pages_path
	end
end
