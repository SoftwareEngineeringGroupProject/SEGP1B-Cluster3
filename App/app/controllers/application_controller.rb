class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  end

 def profile
 	@user = User.find(params[:username])
  	if session[:signed_in] == true
  	  if @user.username == "Admin"
  	  	redirect_to "dashboards/view"
  	  end
  	else
  	   session[:signed_in] == false
  	   redirect_to '/login'
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
  
  #Save user logged in session
  protected 
  def authenticate_user
  	if session[:user_id]
    	# set current user object to @current_user object variable
    	@current_user = User.find session[:user_id] 
    	return true	
  	else
    	redirect_to(:controller => 'sessions', :action => 'login')
    	return false
  	end
  end
  
  def user_logged_in?
  	if session[:user_id] != nil
  		@current_user = User.find(session[:user_id])
  		if @current_user != nil
  			return true
  		else
  			return false
  		end
  	else
  		return false
  	end
  end

	def save_login_state
		if session[:user_id]
			redirect_to :root
    		return false
  		else
    		return true
  		end
	end

end
