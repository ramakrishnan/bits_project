class Admin::VideosController < ApplicationController
layout 'admin'

	def index
		@videos = Video.paginate(:page => params[:page], :per_page => 1)
	end
	
	def new
		@video = Video.new
	end
	
	def edit
		@video = Video.find(params[:id])
	end
	
	def update
		@video = Video.find(params[:id])
		if @video.update_attributes(params[:video])
			redirect_to admin_videos_path
		else
			render :action => :edit
		end
	end
	
	def create
		@video = Video.new(params[:video])
		if @video.save
			redirect_to admin_videos_path
		else
			render :action => :new
		end		
	end
	
	def destroy
		@video = Video.find(params[:id])
		@video.delete
		redirect_to admin_videos_path
	end
end