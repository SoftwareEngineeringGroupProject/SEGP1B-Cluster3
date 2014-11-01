class PastprojectManagementController < ApplicationController
  def new

  end

  def create

  end

  def edit

    if session[:user_id] != nil
      @user = User.find(session[:user_id])
      if @user.acctype != "coordinator"
        flash[:notice] = "Please Login as a coordinator to edit a past project"
        redirect_to :login
      end
    else
      flash[:notice] = "Please Login to edit a past project"
      redirect_to :login
    end

    #fetch the projects Ids that needs to be updated
    @EditArray=params[:editArray]
    @EditArray=@EditArray

    @IdArray=Array.new

    #convert params IDs to int
    @EditArray.each do |element|
      @IdArray.push(element.to_i)
    end

    #get projectManagement record
    @management=PastprojectManagement.find(0)

    #get the pastProjects that have been choosed
    @pastProjects=StudentProject.find(@IdArray)

  end

  def update
    
    @updateManagement=PastprojectManagement.find(0)

    #update the attributes without save to DB yet
    @updateManagement.attributes=manage_params

    #save to DB
    @updateManagement.save
    redirect_to pastproject_management_path

  end

  def destroy

  end

  def manage_params
                 params.require(:pastproject_management).permit(student_project_attributes: [ :id, :title, :summary, :image, :client, :client_image, 
            :category, :year, :client_summary, :client_link,  students_attributes: [:id,:name, :email, :studentID, :course, :_destroy] ])
  end

end
