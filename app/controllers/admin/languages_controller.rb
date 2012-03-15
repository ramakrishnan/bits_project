class Admin::LanguagesController < ApplicationController
	layout "admin"
	
	def index
		@languages = Language.all
	end
	
	def new
		@language = Language.new
	end
	
	def create
		@language = Language.new(params[:language])
		if @language.save
			flash[:notice] = "Language saved"
			redirect_to admin_languages_path
		else
			flash[:errors] = "Language not saved"
			render :action => "new"
		end
	end
	
	def edit
		@language = Language.find(params[:id])
	end
	
	def update
		@language = Language.find(params[:id])
		if @language.update_attributes(params[:language])
			redirect_to admin_languages_path
		else
			render :action => "edit"
		end
	end
	
	def destroy
		@language = Language.find(params[:id])
		@language.destroy if @language
		redirect_to admin_languages_path
	end
end