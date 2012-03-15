class Admin::CategoriesController < ApplicationController
	layout "admin"
	
	def index
		@categories = Category.all
	end
	
	def new
		@actegory = Category.new
	end
	
	def create
		@category= Category.new(params[:category])
		if @category.save
			flash[:notice] = "Category saved"
			redirect_to admin_categories_path
		else
			flash[:errors] = "Category not saved"
			render :action => "new"
		end
	end
	
	def edit
		@category = Category.find(params[:id])
	end
	
	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			redirect_to admin_categories_path
		else
			render :action => "edit"
		end
	end
	
	def destroy
		@category = Category.find(params[:id])
		@category.destroy if @category
		redirect_to admin_categories_path
	end
end