class ProjectsController < ApplicationController
  
  def index
    @projects = StudentProject.all
    # @groups = Group.all
  end

  def new
    @student_project = StudentProject.new
    3.times { @student_project.students.build }
  end

  def create
    @student_project = StudentProject.new(project_params)
    if @student_project.save
      redirect_to :index, :notice => "Project created"
    else
      render :new
    end
    # StudentProject.create(project_params)
  end

  def project_params
    params.require(:student_project).permit(:title, :summary, :image, :client, :year, students_attributes: [:name, :email])
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
