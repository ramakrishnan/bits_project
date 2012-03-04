class Admin::RefinementController < ApplicationController
layout 'admin'
  def show
  	model = params[:type].to_s.camelize.constantize
  	@refinements = model.paginate(:page => params[:page], :per_page => 1)
  	render :layout => false	
  end
end