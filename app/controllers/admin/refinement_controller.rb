class Admin::RefinementController < ApplicationController
layout 'admin'
  def show
  	model = params[:type].camelize.constantize
  	@refinements = model.paginate(:page => params[:page], :per_page => 10)
  	render :layout => false	
  end
end