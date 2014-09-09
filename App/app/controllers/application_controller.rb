class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  end

 def profile
 	@user = User.find(params[:usename])
  	if session[:signed_in] == true
  	  if @user.username == "Admin"
  	  	redirect_to "dashboards/view"
  	  end
  	else
  	   session[:signed_in] == false
  	   redirect_to '/login.html'
  	end
  end

  def login
  	username = params[:username]
  	password = params[:password]
  	@user = (User.all.select{|u| u.username == username}).first
  	if @user == nil
  		
  	else 
  	#@reference_code = params[:reference_code]
  	#@email = params[:email]
  	#binding.pry

  	  #if User.verify_credentials(password, @user.salt, @user.hashed_password)  == false
  	 	session[:singed_in] = true 	
  		redirect_to '/profile'
  	 # end

  	end

  end

  def logout
  end

end
