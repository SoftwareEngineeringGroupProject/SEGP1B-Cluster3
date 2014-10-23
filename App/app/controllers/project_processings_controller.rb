class ProjectProcessingsController < ApplicationController
  # Allow coodinator to edit and update the project details comprenhensively after
  # they have been accepted and fully specified via industry communication

  def edit_project

    # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end

    # This needs a project to edit, otherwise redirect_to admin_dashboard
    if ( !params[:id].blank? )
      @project = Project.find(params[:id])
      @spec = Spec.find_by_project_id(params[:id])
      @spec_link = '"http://localhost:3000/project_specification/'+@spec.auth_token+ '"'
    else
      @project = Project.new
    end

  end

  def post_from_editing_project
     # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end

    if params[:project_id].blank?
      flash[:notice] = "Select a project to edit!"
      edit_project
      render :edit_project
      return
    end

    @project = Project.find((params[:project_id]))

    if ( params[:commit] == "Edit" )
      @spec = Spec.find_by_project_id(params[:project_id])
      redirect_to "/editor/project_spec_gens/" + params[:project_id]
      return
    elsif ( params[:commit] == "Preview")
      redirect_to "/project_spec_gens/" + params[:project_id]
      return
    end
    edit_project
    render :edit_project
  end


  # After the project is accepted, coordinator can assign students
  # to the project and send them emails as well the extra info about the project

  def assign_student

    # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end

    # This needs a project to edit, otherwise redirect_to admin_dashboard
    if !params[:project_id].blank?
      @project = Project.find(params[:project_id])
      @spec = @project.spec
      @spec_link = '<http://localhost:3000/project_specification/'+@spec.auth_token+ '>'
    else
      redirect_to admin_dashboard_path
    end

    if (@project.assigned_students.count == 3) 
      @student1 = @project.assigned_students[0];
      @student2 = @project.assigned_students[1];
      @student3 = @project.assigned_students[2];
      @group_name = @student3.group_name
    else
      @student1 = AssignedStudent.new
      @student2 = AssignedStudent.new
      @student3 = AssignedStudent.new 
    end

  end

  def post_from_assigning_student
     # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end

    if (params[:project_id].blank? )
      flash[:notice] = "Specify the project that you want to work with first!"
      assign_student
      render :assign_student
      return
    end
    
    @project = Project.find(params[:project_id])

    if (params[:commit] == "Assign")

      # Send a message to the selected project
      if !params[:group_name].blank? && !params[:student1].blank? && !params[:student2].blank? && !params[:student3].blank? && !params[:message].blank?

        AssignedStudent.all.each do |aS|
          aS.delete if aS.project_id == @project.id
        end
        @student1 = AssignedStudent.new
        @student2 = AssignedStudent.new
        @student3 = AssignedStudent.new

        @student1 = @project.assigned_students.build(:studentID=>params[:student1], :group_name => params[:group_name])
        @student2 = @project.assigned_students.build(:studentID=>params[:student2], :group_name => params[:group_name])
        @student3 = @project.assigned_students.build(:studentID=>params[:student3], :group_name => params[:group_name])

        if @student1.save && @student2.save && @student3.save
          send_emails_to_project_team
        else
          @student1.delete
          @student2.delete      
          @student3.delete
        end

      else
        flash[:notice] = "Some fields are missing!"
      end

    elsif (params[:commit] == "Cancel") 
      redirect_to project_manip_path(id: @project.id)
      return
    end
    assign_student
    render :assign_student
  end

  private

    def send_emails_to_project_team

      recipients = AssignedStudent.all.map{|s| s.studentID + "@student.adelaide.edu.au" unless s.project_id != @project.id}
      @current_user = User.find(session[:user_id])
      @subject = "Team formation"
      # Send the message to the user's email
      UserMailer.email_message_to_multi_recipients(params[:message], recipients, @subject, nil).deliver
      flash[:notice] = "Message has been delivered to all of the assigned students"
    end

end
