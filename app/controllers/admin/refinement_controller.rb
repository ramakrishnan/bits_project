class Admin::RefinementController < ApplicationController
layout 'admin'
  def show
  	model = params[:type].to_s.camelize.constantize
  	if params[:category].blank? and params[:language].blank?
  		@refinements = model.paginate(:page => params[:page], :per_page => 10)
  	else
	  	refinements = model.join_category(params[:category]) unless params[:category].blank?
	  	if !params[:language].blank?
	  		if refinements
				refinements = refinements.join_language(params[:language])
			else
	  			refinements = model.join_language(params[:language])
			end
		refinements = refinements.paginate(:page => params[:page], :per_page => 10)
	  	@refinements = refinements
  		end
  	end
  	render :layout => false	
  end
end