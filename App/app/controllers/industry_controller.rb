class IndustryController < ApplicationController

	def showList
		#should be using reference code to find company
		@company = Company.find(params[:id])
		@projects = Project.all.select{|project| project.company_id == @company};
	end

	
	def edit
    	@project = Project.find(params[:id]);
        @company = @project.company
        @attached = @project.attached    	
    end
	
	def update
		#update the new information for project
    	@project = Project.find(params[:id]);
        @company = @project.company
        @attached = @project.attached    

		#redirect to show project page if success
		if @project.update(project_params) && @company.update(company_params) && @attached.update(attached_params)
		  redirect_to show_single_submission_path(@project)
		else
		#otherwise, stay in edit page
		  render :edit
		end 
	end
	
	def remove
    	@project = Project.find(params[:id]);
        @attached = @project.attached  
		
		#remove both
		@project.destroy
		@attached.destroy
		
		redirect_to show_all_submissions_path
	end
	
	private
    def project_params
      params.require(:project).permit(:title, :body)
    end 

    def company_params
      params.require(:company).permit(:name, :address, :phone, :email, :website)
    end 

    def attached_params
      params.require(:attached).permit(:attached, :project_id)
    end   
  
end
