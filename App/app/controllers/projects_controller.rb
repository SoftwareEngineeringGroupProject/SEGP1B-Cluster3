class ProjectsController < ApplicationController
  before_action :get_admin , :only => [:check_auth, :new, :index]
  # before_action :index , :only => [:check_logged_in]
  after_action :check_logged_in, except: [:check_auth, :logout, :new]
  
  def get_admin
    @admin = Admin.find(1)    
  end

  def check_logged_in
    
  end

  def check_auth
    if ( params[:username] == @admin.username && params[:password] == @admin.password )   
      session[:username] = @admin.username
      redirect_to root_path ,:notice => "Welcome " + @admin.username

    else
      flash[:notice] = "Incorrect username/password"
      redirect_to root_path
      
    end
  end


  def index
    @projects = Admin.all
if session[:username] == @admin.username
      render layout: "loggedin"
    end
  end

  def logout
    session[:username] = nil
    redirect_to root_path ,:notice => "Successfully logged out"
  end

  def new
    # if session[:username] != @admin.email
    #   redirect_to root_path ,:notice => "Only admins are allowed to submit projects"
    # end



  end

  def create
    @project = Project.new
    @project.title = params[:title]
    @project.group = params[:group]
    @project.summary = params[:summary]
    @project.members = params[:members]
    @project.extra = params[:extra]
    @project.save

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
end
