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
  

end
