class UsersController < ApplicationController

	def index
		@users = User.all
	end
	
	def new
		@user = User.new
	end

	def create
		#Get submitted form data
		username = params[:username]
		email = params[:email]
		password = params[:password]
		passwordconf = params[:confirm_password]

		#try to create a user
  		@user = User.create_with_credentials(username, email, password)
  		if @user != nil
  			#Successfully created, redirect
  			redirect_to :list_all_path
  		else
  			#Error in creation, display form again
  			render 'new'
  		end
	end
	
	def show
		@user = User.find(params[:id])
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(params[:id])
 
  		if @user.update(user_params)
    		redirect_to @user
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
    	params.require(:user).permit(:username, :email, :password, :confirm_password)
  	end
  
end
