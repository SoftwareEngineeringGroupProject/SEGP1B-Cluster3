class UsersController < ApplicationController
	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
	before_filter :save_login_state, :only => [:new, :create]

	def index
		if user_logged_in?
			@users = User.all
			render "listaccounts"
		else
			flash[:notice] = "Account Successfuly Created. Please Log In to Continue"
			redirect_to :unauthorized
		end
	end

	def new
		#Signup Form
		@industryuser = User.new
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
  		@industryuser = User.new(user_params)
  		@industryuser.acctype = "industry"
    	if @industryuser.save
    		flash[:notice] = "Account Successfuly Created. Please Log In to Continue"
    		UserMailer.email_signup_password_industry(@industryuser).deliver
    		redirect_to :login
    	else
      		render "new"
    	end
  	end

  	def createadmin
  		if user_logged_in?
  			@newadminuser = User.new(admin_params)
  			@newadminuser.passwordvalid = -1
  			randompw = (0...8).map { (65 + rand(26)).chr }.join
  			@newadminuser.password = randompw
  			@newadminuser.password_confirmation = randompw
    		if @newadminuser.save
    			UserMailer.email_signup_password(@newadminuser, randompw).deliver
    			flash[:notice] = "Account Successfuly Created for Other Admin."
    			redirect_to :admin_signup_path
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
			if user_type == "coordinator"
				@showuser = User.find(params[:id])
			else
				redirect_to "unauthorized"
			end
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

	def editprofile
		if user_logged_in?
			@user = @current_user
			if user_type == "industry"
				render "editprofile"
			else
				render "editprofile"
			end
		else
			redirect_to :login
		end
	end


	def submitprofileedits
		if user_logged_in?
			@user = @current_user
			if @user.update(edit_user_params)
				flash[:notice] = "Your Details have been updated"
				redirect_to :profile
			else
				if EMAIL_REGEX.match(params[:email])
					#don't know why it failed
					flash[:notice] = "Unable to edit your details"
				render 'editprofile'
				else
					flash[:notice] = "Email Address is Invalid"
					render 'editprofile'
				end
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
    			flash[:notice] = "New Password sent to #{@user.email}"
    			UserMailer.email_new_password(@user, randompw).deliver
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
		if user_logged_in?
			if user_type == "coordinator"
				@useredit = User.find(params[:id])
				render "edit"
			else
				redirect_to "unauthorized"
			end
		else
			redirect_to :login
		end
	end

	def update
		if user_logged_in?
			if user_type == "coordinator"
				@useredit = User.find(params[:id])
  				if @useredit.update(update_user_params)
    				redirect_to :list_all_path
  				else
    				render 'edit'
  				end
  			else
  				redirect_to "unauthorized"
  			end
  		else
  			redirect_to :login
  		end
	end

	def destroy
		if user_logged_in?
			if user_type == "coordinator"
				@userdelete = User.find_by_id(params[:id])
				if params[:id] != @current_user.id
					@userdelete.delete
				end
				redirect_to :list_all_path
			else
				redirect_to "unauthorized"
			end
		else
			redirect_to :login
		end
	end

	private
  	def user_params
    	params.require(:user).permit(:username, :email, :password, :password_confirmation, :fname, :lname, :companyname, :address, :phone, :website)
  	end

  	def edit_user_params
    	params.require(:user).permit(:email, :fname, :lname, :phone)
  	end

  	def update_user_params
    	params.require(:useredit).permit(:username, :email, :fname, :lname, :phone)
  	end

  	def admin_params
    	params.require(:admin_user).permit(:username, :email, :fname, :lname, :acctype)
  	end

  	def match_password(login_password="")
  		hashed_password == BCrypt::Engine.hash_secret(login_password, salt)
	end
end
