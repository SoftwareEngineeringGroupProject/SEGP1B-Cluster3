class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		#@user = User.new(user_params)
		username = user_params[:username]
		email = user_params[:email]
		password = user_params[:hashed_password]

  		@user=User.create_with_credentials(username, email, password)
  		if @user != nil
				UserMailer.welcome_email(@user).deliver
  			redirect_to @user
  		else
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
		@user.destroy

		redirect_to users_path
	end

	private
  	def user_params
    	params.require(:user).permit(:username, :email, :hashed_password)
  	end

end
