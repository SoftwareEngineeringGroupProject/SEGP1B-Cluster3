class ProjectsController < ApplicationController
  
  def index
    @projects = StudentProject.all
    # @groups = Group.all
  end

  def new
    @project = StudentProject.new
    3.times { @project.students.build }
  end

  def create
    @project = StudentProject.new(project_params)
    if @project.save
      redirect_to :index, :notice => "Project created"
    else
      render :new
    end
  end

  def project_params
    params.require(:StudentProject).permit(:title, :summary, :image, :client, students_attributes: [:name, :email])
  end

  def show
  end

  def edit
  end

  def update

  end

  def destroy
  end

  def info
  end

  def contact
  end

end
