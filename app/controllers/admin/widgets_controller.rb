class Admin::WidgetsController < ApplicationController
layout 'admin'

	def index
		@widgets = Widget.all
	end
	
	def new
		@widget = Widget.new
	end
	
	def edit
		@widget = Widget.find(params[:id])
		@categories = Category.all
		@languages = Language.all
	end
	
	def update
		@widget = Widget.find(params[:id])
		if @widget.update_attributes(params[:widget])
			@widget.collections.each do |collection|
				collection.update_attributes(params[:collection])
			end
			redirect_to admin_widgets_path
		else
			render :action => :edit
		end
	end
	
	def create
		@widget = Widget.new(params[:widget])
		if @widget.save
			@widget.collections.create if @widget.widget_type == 3
			redirect_to admin_widgets_path
		else
			render :action => :new
		end		
	end
	
	def destroy
		Widget.destroy(params[:id])
		redirect_to admin_widgets_path
	end
	
end
