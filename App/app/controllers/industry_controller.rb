class IndustryController < ApplicationController

	def showList

    		if (params[:id] != nil)
			#should be using reference code to find company
			@company = Company.find(params[:id])
			@projects = Project.all.select{|project| project.company_id == @company.id};
		end
	end

	def action_to_project
		if ( params[:commit]=='Edit' )
			redirect_to edit_industry_project_path
		end

		if ( params[:commit]=='Delete' )
			redirect_to delete_industry_project_path
		end

		if ( params[:commit]=='Submit New' )
			redirect_to :submit_new_project
		end
	end

	def edit
    		if (params[:id] != nil)
		    	@project = Project.find(params[:id]);
			@company = @project.company
			@attached = @project.attached   
		end 	
    	end
	
	def update
		#update the new information for project
	    	@project = Project.find(params[:id]);
		@company = @project.company
		@attached = @project.attached    

		#redirect to show project page if success
		if @project.update(project_params) 
		  redirect_to :show_all_industry_project
		else
		#otherwise, stay in edit page
		  render edit
		end 
	end
	
	def delete	
		@message = Message.new
		@message.subject = ""
		@message.body = ""
	    	if (params[:id] != nil)
		    	@project = Project.find(params[:id]);
			
		end 

		
	end

	def pending
	    	if (params[:id] != nil)
		    	@project = Project.find(params[:id]);
		end 
		
		@message = @project.messages.build(message_params)
		if (@message.save)
		  redirect_to :show_all_industry_project
		else
		#otherwise, stay in edit page
		  render :pending
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
		params.require(:message).permit(:subject, :body)
	    end

	    def attached_params
	      params.require(:attached).permit(:attached, :project_id)
	    end   
  
end
