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
      @spec_link = '"http://localhost:3000/project_spec_gens/' + (@project.id).to_s + '"'
    else
      @project = Project.new
    end

  end

  def post_from_editing_project
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
    else
      flash[:notice] = "Specify the project that you want to work with first!"
      @project = Project.new
    end

    @assigned_students = Student.all.select { |s| s.project_id == @project.id && @project != nil }
    @students = Student.all.select {|s| s.is_new == true && s.project_id == nil}

    @email = "To: "
    Student.all.each do |student|
      if student.project_id == @project.id && student.project_id != nil
        @email += "<#{student.email}>"
      end
    end

  end

  def post_from_assigning_student

    if (params[:project_id].blank? )
      flash[:notice] = "Specify the project that you want to work with first!"
      assign_student
      render :assign_student
      return
    end
    @project = Project.find(params[:project_id])

    if (params[:commit] == "Send")

      # Send a message to the selected project
      if (params[:subject] == "" || params[:email]=="")
        flash[:notice] = 'Subject or message fields are missing!'
      else
        send_emails_to_project_team
      end

      assign_student
      render :assign_student
      return
    end

    if (params[:student_id].blank?)
      flash[:notice] = "Select a student"
      assign_student
      render :assign_student
      return
    end
    @student = Student.find(params[:student_id])

    if ( params[:commit] == "Add" )
      @student.update_attributes(:project_id => @project.id)
    elsif (params[:commit] == "Remove")
      @student.update_attributes(:project_id => nil)
    end

    assign_student
    render :assign_student

  end

  private

    def send_emails_to_project_team

      recipients = Student.all.map{|student| student.email unless student.project_id != @project.id}
      @current_user = User.find(session[:user_id])
      file = params[:attachment]

      # Send the message to the user's email
      UserMailer.email_message_to_multi_recipients(params[:email], recipients, params[:subject], file).deliver
      flash[:notice] = "Message has been delivered to all of the assigned students"
    end

end
