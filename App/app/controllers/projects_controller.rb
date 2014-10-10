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
    # @projects = Admin.all
    @projects = StudentProject.all
    # @groups = Group.all
  end

  def logout
    session[:username] = nil
    redirect_to root_path ,:notice => "Successfully logged out"
  end

  def new
    @project = StudentProject.new
    3.times do
      students = @project.students.build
    end
    # if session[:username] != @admin.email
    #   redirect_to root_path ,:notice => "Only admins are allowed to submit projects"
    # end
  end

  def create
    @project = StudentProject.new(user_params)
    # @projects = StudentProject.new
    # @projects.title = params[:title]
    # @projects.group = params[:group]
    # @projects.summary = params[:summary]
    # @projects.members = params[:members]
    # @projects.extra = params[:extra]
    # @projects.image = params[:image]
    if @project.save
      redirect_to :index, :notice => "Project created"
    else
      render :new
    end
  end

  def user_params
    params.require(:StudentProject).permit(:title, :summary, :extra, :image)
  end

  def group_params
    params.require(:group).permit(:name, :numOfMembers)
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
