class UsersController < ApplicationController
	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
	before_filter :save_login_state, :only => [:new, :create]

	def index
		@users = User.all
	end

	def new
		#Signup Form
		@user = User.new
		render "new"
	end
	
	def newadmin
		if user_logged_in?
			#Signup Form
			@newadminuser = User.new
			render "newadmin"
		else
			redirect_to :login
		end
	end

	def create
  		@user = User.new(user_params)
    	if @user.save
    		flash[:notice] = "Account Successfuly Created. Please Log In to Continue"
    		redirect_to :login
    	else
      		render "new"
    	end
  	end
  
  	def createadmin
  		if user_logged_in?
  			@newadminuser = User.new(user_params)
    		if @newadminuseruser.save
    			flash[:notice] = "Account Successfuly Created. Please Log In to Continue"
    			render :admin_signup_path
   			else
    			flash[:notice] = "Unable to Create new Coordinator Account"
      			render "newadmin"
    		end
    	else
    		redirect_to :login
    	end
  	end

	def show
		if user_logged_in?
			@user = User.find(params[:id])
		else
			redirect_to :login
		end
	end
	
	def profile
		if user_logged_in?
			if user_type == "industry"
				render "profile"
			else
				render "profile"
			end
		else
			redirect_to :login
		end
	end
	
	def changepw
		if user_logged_in?
			if user_type == "industry"
				render "changepw"
			else
				render "changepw"
			end
		else
			redirect_to :login
		end
	end
	
	def performreset
		if user_logged_in?
			if BCrypt::Engine.hash_secret(params[:login_password], @current_user.salt) == @current_user.hashed_password
				if params[:new_password].length >= 6
					if params[:new_password] == params[:confirm_password]
						newsalt = BCrypt::Engine.generate_salt
						new_hashed_password = BCrypt::Engine.hash_secret(params[:new_password], newsalt)
						@current_user.update_attribute("salt", newsalt)
						@current_user.update_attribute("hashed_password", new_hashed_password)
						@current_user.update_attribute("passwordvalid",0)
						if @current_user.save
							flash[:notice] = "Password Successfully Updated"
							UserMailer.email_new_password("moo")
							redirect_to :change_pw
						else
							flash[:notice] = "Unable to Update Password"
							redirect_to :change_pw
						end
					else
						flash[:notice] = "Confirmation Password does not match New Password"
						redirect_to :change_pw
					end
				else
					flash[:notice] = "New password must be at least 6 chracters in length"
					redirect_to :change_pw
				end
			else
				flash[:notice] = "Current Password is incorrect!"
				redirect_to :change_pw
			end	
		else
			flash[:notice] = "You muct be logged in to change your password!"
			redirect_to :login
		end
	end
	
	def forgot_password
		render "forgottenpassword"
	end
	
	def email_new_password
		username_or_email = params[:username_or_email]
		if  EMAIL_REGEX.match(username_or_email)
			@user = User.find_by_email(username_or_email)
		else
			@user = User.find_by_username(username_or_email)
    	end
    	if @user != nil
    		#generate random password
    		randompw = (0...8).map { (65 + rand(26)).chr }.join
    		newsalt = BCrypt::Engine.generate_salt
    		new_hashed_password = BCrypt::Engine.hash_secret(randompw, newsalt)
    		@user.update_attribute("salt", newsalt)
    		@user.update_attribute("hashed_password", new_hashed_password)
    		@user.update_attribute("passwordvalid", -1)
    		if @user.save
    			flash[:notice] = "New Password #{randompw} sent to #{@user.email}"
				UserMailer.email_new_password(randompw)
				redirect_to :login
    		else
    			flash[:notice] = "Unable to reset users password. Unknown error. Please try again later"
    		end
    	else
    		flash[:notice] = "User not found!"
    		render "forgottenpassword"
    	end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

  		if @user.update(user_params)
    		redirect_to :list_all_path
  		else
    		render 'edit'
  		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.delete
		redirect_to :list_all_path
	end

	private
  	def user_params
    	params.require(:user).permit(:username, :email, :password, :password_confirmation, :fname, :lname, :companyname, :address, :phone, :website, :acctype)
  	end
  	
  	def match_password(login_password="")
  		hashed_password == BCrypt::Engine.hash_secret(login_password, salt)
	end

end
