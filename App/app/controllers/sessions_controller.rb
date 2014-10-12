class SessionsController < ApplicationController

  before_filter :authenticate_user, :only => [:admin_dashboard, :home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def home
  end

  def profile
  end

  def setting
  end
  
  def unauthorized
  	render "unauthorized"
  end

  def login_attempt
  	authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
  	if authorized_user
	  session[:user_id] = authorized_user.id
	  if authorized_user.passwordvalid == -1
	  	#Logging in with temporary password...
	  	flash[:notice] = "Please change your password."
	  	redirect_to :change_pw
	  else
	  	if authorized_user.acctype == "industry"
      		#flash[:notice] = "Indursty Partner: #{authorized_user.username} Logged In"
      		redirect_to root_path
      	elsif authorized_user.acctype == "coordinator"
      		#flash[:notice] = "Coordinator: #{authorized_user.username} Logged In"
      		redirect_to root_path
      	else
      		#flash[:notice] = "Unknown Account Type"
      		redirect_to root_path
      	end
      end
    else
      flash[:notice] = "Sorry... Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to root_path
  end

end
