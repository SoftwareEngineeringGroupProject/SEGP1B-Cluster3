class SubmissionsController < ApplicationController
	
  def index 
  end

  def new
    @project = Project.new
	@company = Company.new
	@attached = Attached.new
  end

  def create
	@company = Company.new(company_params)
	@project = @company.projects.build(project_params)
	@attached =@project.build_attached(attached_params)

	if @project.save && @company.save && @attached.save
	  redirect_to submission_path(@project)
	else
	  render :new
	end	

  end

  def show
  	@project = Project.find(params[:id]);
  	@company = @project.company
  	@attached = @project.attached
  end

  private
    def project_params
      params.require(:project).permit(:title, :body)
    end	

    def company_params
      params.require(:company).permit(:name, :address, :phone, :email, :website)
    end	

    def attached_params
      params.require(:attached).permit(:attached, :project_id)
    end 	
end
