class Admin::RefinementController < ApplicationController
layout 'admin'
  def show
  	model = params[:type].to_s.camelize.constantize
  	options = {}
  	options.merge!(:category => params[:category]) unless params[:category].blank?
  	options.merge!(:language => params[:language]) unless params[:language].blank?
  	
  	result = Collection.find_all_for(model, options )
	@refinements = result.paginate(:page => params[:page], :per_page => 10)
  	render :layout => false	
  end
end