class UsersController < ApplicationController
	before_filter :save_login_state, :only => [:new, :create]

	def index
		@users = User.all
	end

	def new
		#Signup Form
		@user = User.new
		@company = Company.new
		render "new"
	end

	def newadmin
		#Signup Form
		@user = User.new
		render "newadmin"
	end

	def create

		# Create a new user
  	@user = User.new(user_params)

		# Temporary variable
		@company = Company.new(name: "name", address: "address", phone: "phone", website: "website", user_id: 1);
		if @user.acctype == "industry"
			@company = @user.build_company(company_params)
		end

		# Save them to database
    if @user.save && @company.save

			# if user is a coodinator, then he/she don't need a company
			if @user.acctype == "coordinator"
				@company.delete
			end

			# If everything's gone well
    	flash[:notice] = "Account Successfuly Created. Please Log In to Continue"
			UserMailer.welcome_email(@user)
    	redirect_to :login
    else

			@user.delete
			@company.delete

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

		def company_params()
			params.require(:company).permit(:name, :address, :phone, :email, :website,:user_id)
		end
end
