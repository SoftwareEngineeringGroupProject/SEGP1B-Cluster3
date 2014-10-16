class IndustryController < ApplicationController

	# View projects and its states
	def showList
		# Initialize project list and authenticate user
		@projects = {}
		authenticate_user
		if (@current_user == nil) || (@current_user.acctype != "industry")
			flash[:notice] = "You have an Coordinate Partner Account, NOT a Industry account"
			redirect_to :unauthorized
		end

		# Initialize this date parameter
		params[:date] = "02/12/1995" if params[:date] == "Filter by date" || params[:date] == nil

		# Collect projects submitted by current user and based on date filter
		@projects = @current_user.projects.select{ |project| compare_date(project.created_at.strftime("%m/%d/%Y"), params[:date] ) }

		# Define how to display the white board, either display description or message log
		@des = !@log
	end

	# Apply different actions to the project
	def action_to_project

		# Only "Submit New" and "Date Filter" can proceed without a project selected
		if ( params[:commit]=='Submit New' )
			redirect_to new_submission_path
			return
		end

		if ( params["Filter.x"])
			showList
			render :showList
			return
		end

		# If user has not selected any project, back to main board with a message
		if params[:project_id] == nil
			showList
			flash[:notice] = 'Select a project before applying your action!'
			render :showList
			return
		end

		@project = Project.find(params[:project_id])

		if ( params[:commit]=='Edit' )
			render :edit
			return
		end

		if ( params[:commit]=='Delete' )
			redirect_to delete_industry_project_path(:project_id => @project.id)
			return
		end

		if ( params[:commit]=='Project Description')
		  @des = true
			@log = false
			redirect_to industry_dashboard_path
			return
		end

		if ( params[:commit]=='Message Log')
			showList
			@des = false
			@log = true
			@message_log = @project.messages
			render :showList
			return
		end

		if ( params[:commit] == 'Send')
			send_message
		end

		showList
		render :showList
	end

	def edit
		if @project == nil
			redirect_to industry_dashboard_path
		end
  end

	def update
		@project = Project.find(params[:project][:project_id])
		# Redirect to show project page if successful
		if @project.update(project_params)
		  redirect_to :industry_dashboard
		else
		# Otherwise, stay in edit page
		  render :edit
		end
	end

	def delete
		@message = Message.new
		@project = Project.find(params[:project_id])
	  if ( @project == nil )
			redirect_to industry_dashboard_path
		end
	end

	def pending
		@project = Project.find(params[:message][:project_id])
		@message = @project.messages.build(message_params)
		@message.sender_id = session[:user_id];

		if (@message.save)
			# Update project state and redirect to main page
			@project.update_attributes(:status => "pending")
		  redirect_to industry_dashboard_path
		else
			# Otherwise, stay in edit page
		 	render :delete
		end
	end

	private
	  def project_params
	    params.require(:project).permit(:title, :body)
	  end

	 	def message_params
			params.require(:message).permit(:title, :text)
	  end

		def compare_date(before, after)
			before = before.split("/")
			after = after.split("/")
			before[2] + " " + before[1] + " " + before[0] >= after[2] + " " + after[1] + " " + after[0]
		end

		def send_message
			# Identify the user that owns the project
			@current_user = User.find(session[:user_id])
			# Create message
			@message = Message.new(:sender_id => @current_user.id, :project_id => @project.id, :title => params[:subject], :text => params[:email])
			# Save message and notify user any problem
			if !@message.save
				flash[:notice] = "Subject and Message must be not blank!"
				return
			end
			flash[:notice] = "Message has been delivered to project coordinators. You can find your message in message log"
		end

end