class UsersController < ApplicationController
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
		#Signup Form
		@user = User.new
		render "newadmin"
	end

	def create
  	@user = User.new(user_params)
    if @user.save
    	flash[:notice] = "Account Successfuly Created. Please Log In to Continue"
    	redirect_to :login
    else
    	if @user.acctype == "industry"
      		render "new"
      	elsif @user.acctype == "coordinator"
      		render "newadmin"
      	else
      		render "new"
      	end
    end
  end

	def show
		@user = User.find(params[:id])
	end
	
	def profile
		if user_logged_in?
			if user_type == "industry"
				render "profile"
			else
				redirect_to :root
			end
		else
			redirect_to :root
		end
	end
	
	def changepw
		if user_logged_in?
			if user_type == "industry"
				render "changepw"
			else
				redirect_to :root
			end
		else
			redirect_to :root
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
