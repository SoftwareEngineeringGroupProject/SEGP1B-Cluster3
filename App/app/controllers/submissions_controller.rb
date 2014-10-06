class SubmissionsController < ApplicationController

  def index

  end

  def new
  	if session[:user_id] != nil
  		@current_user = User.find(session[:user_id])
  	end
  	if @current_user != nil
  		# Create a submission
    	@project = Project.new
   		@company = Company.new
    	@attached = Attached.new
    else
  		flash[:notice] = "Please Login to Submit a Project"
  		redirect_to :login
  	end

  end

  def create

    # Create association between new objects
    @company = Company.new(company_params)
    @project = @company.projects.build(project_params)
    @attached =@project.build_attached(attached_params)

    # Set state for newly submitted project
    @project.status = "new"

    # If submission is done successfully, redirect to show page
    if @project.save && @company.save && @attached.save
      redirect_to submission_path(@project)
    else
    # Else, render the submission page
      render :new
    end

  end

  def update
  end

  def show
    # Show what user has submited
    @project = Project.find(params[:id]);
    @company = @project.company
    @attached = @project.attached
  end


  # Required due to strong parameter mechanisms
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
