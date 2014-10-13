class IndustryController < ApplicationController

	def showList
		@projects = {}
		authenticate_user
		if (@current_user == nil) || (@current_user.acctype != "industry")
			flash[:notice] = "You have an Coordinate Partner Account, NOT a Industry account"
			redirect_to :unauthorized
		end

		# Should be using reference code to find company
		@projects = @current_user.projects
	end

	def action_to_project

		if ( params[:commit]=='Edit' )
			@project = Project.find(params[:project_id])
			render :edit
		end

		if ( params[:commit]=='Delete' )
			redirect_to delete_industry_project_path(:project_id => params[:project_id])
		end

		if ( params[:commit]=='Submit New' )
			redirect_to new_submission_path
		end
	end

	def edit
		if @project != nil
		else
			flash[:notice] = 'Select a project before applying your action!'
			redirect_to industry_dashboard_path
		end
  end

	def update

		@project = Project.find(params[:project][:project_id])

		# Redirect to show project page if success
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

	    def company_params
	      params.require(:company).permit(:name, :address, :phone, :email, :website)
	    end

	    def message_params
		params.require(:message).permit(:title, :text)
	    end

end
