class ProjectsController < ApplicationController
  
  def index
    @projects = StudentProject.all
    # @groups = Group.all
  end

  def new
    # @students = Student.all
    @student_project = StudentProject.new
    3.times { @student_project.students.build }
  end

  def create
    @student_project = StudentProject.new(project_params)
    if @student_project.save
      redirect_to :index, :notice => "Project created"
    else
      redirect_to :new
    end
    # StudentProject.create(project_params)
  end

  def project_params
    params.require(:student_project).permit(:title, :summary, :image, :client, :year, students_attributes: [:name, :email, :studentID, :course])
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
