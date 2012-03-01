class Admin::GridsController < ApplicationController
layout 'admin'
	def index
		@grids = Grid.all
	end
		
	def create
		@grid = Grid.new(params[:grid])
		if @grid.save
			redirect_to admin_grids_path
		else
			render :action => "new"
		end
	end
	
	def new
		@grid = Grid.new
	end
	
	def edit
		@grid = Grid.find(params[:id])
	end
	
	def update
		@grid = Grid.find(params[:id])
		if @grid.update_attributes(params[:grid])
			redirect_to admin_grids_path
		else
			render :action => "edit"
		end
	end
end
