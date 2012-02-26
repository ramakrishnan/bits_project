class Admin::TemplatesController < ApplicationController
layout 'admin'
	def index
		@templates = Template.find(:all)
	end
		
	def create
		@template = Template.new(params[:template])
		if @template.save
			redirect_to admin_templates_path
		else
			render :action => "new"
		end
	end
	
	def new
		@template = Template.new
	end
	
	def edit
		@template = Template.find(params[:id])
	end
	
	def update
		@template = Template.find(params[:id])
		if @template.update_attributes(params[:template])
			redirect_to admin_templates_path
		else
			render :action => "edit"
		end
	end
end
