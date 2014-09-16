class DashboardsController < ApplicationController

  def view
  	#authenticate user first
  	
  	authenticate_user
    # View projects based on project state
    @state = params[:state]



    @projects = Project.all.select{|project| project.status == @state};
   
  end

  def change_state
    # Possible status
    status = ["accepted", "pending", "new", "rejected"]

    # If user have selected a project to apply an action
    if (params[:project_id] != nil)

      @project = Project.find(params[:project_id])


      if ( status.include? params[:commit] )
      # This is for updating status
        @project.update_attributes({:status => params[:commit]})    
      else 
      # Specific actions 
        if ( params[:commit]=="remove" )
          delete
        end
      end  

    end  

    # Anyway, just render the same page
    @projects = Project.all.select{|project| project.status == params[:state]};
    @state = params[:state]
    render :view

  end

  private

    def delete
     Project.destroy(params[:project_id]);
    end



end
