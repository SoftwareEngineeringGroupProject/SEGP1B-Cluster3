class ProjectsController < ApplicationController
  # before_action :get_admin , :only => [:check_auth, :new, :index]
  # before_action :index , :only => [:check_logged_in]
  after_action :check_logged_in, except: [:check_auth, :logout, :new]
  
 

  def check_logged_in

  end

  # def check_auth
  #   if ( params[:username] == @admin.username && params[:password] == @admin.password )   
  #     session[:username] = @admin.username
  #     redirect_to root_path ,:notice => "Welcome " + @admin.username

  #   else
  #     flash[:notice] = "Incorrect username/password"
  #     redirect_to root_path
      
  #   end
  # end


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
    params.require(:StudentProject).permit(:title, :summary, :extra, :image, :students)
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
