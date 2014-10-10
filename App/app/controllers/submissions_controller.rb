class SubmissionsController < ApplicationController

  def index

  end

  def new
  	if session[:user_id] != nil
  		@current_user = User.find(session[:user_id])
  	end
  	if @current_user != nil

  		# Create a submission
      @company = Company.new
    	@project = Project.new

    else
  		flash[:notice] = "Please Login to Submit a Project"
  		redirect_to :login
  	end
  end

  def create

    @current_user = User.find(session[:user_id])
    @company = Company.find_by_user_id(session[:user_id])
    @project = @company.projects.build(project_params)

    # Set state for newly submitted project
    @project.status = "new"

    # If submission is done successfully, redirect to show page
    if @project.save
      redirect_to submission_path(@project)
    else
      # Else, render the submission page
      @project.delete
      render :new
    end

  end

  def show
    # Show what user has submited
    @project = Project.find(params[:id]);
    @company = @project.company
  end


  # Required due to strong parameter mechanisms
  private
    def project_params
      params.require(:project).permit(:title, :body, :attachment)
    end
end
