class UsersController < ApplicationController

	def index
		@users = User.all
	end
	
	before_filter :save_login_state, :only => [:new, :create]

	def new
		#Signup Form
		@user = User.new     
	end

	def create
    	@user = User.new(user_params)
    	if @user.save
    		redirect_to :login_path
      	else
        	render "new"
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
    	params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	end
  
end
