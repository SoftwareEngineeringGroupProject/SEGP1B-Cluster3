class ProjectSpecGensController < ApplicationController

  def update
     # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end
    @spec = Spec.find_by_project_id(params[:id])
    @spec.spec_name = params[:content][:spec_name][:value]
    @spec.spec_content = params[:content][:spec_content][:value]
    @spec.save!
    render text: ""
  end

  def show
     # Authenticate user first
    if (params[:auth_token] == nil) 
      authenticate_user
      if (@current_user == nil) || (@current_user.acctype != "coordinator")
        flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
        redirect_to :unauthorized
      end
      @spec = Spec.find_by_project_id(params[:id])
    else
      @spec = Spec.find_by_auth_token(params[:auth_token])
      if (@spec == nil) 
        redirect_to :unauthorized
      end
    end 
  end

end
