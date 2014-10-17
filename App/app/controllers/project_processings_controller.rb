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

    # Current working set
    @cart = Project.all.select{|p| p.in_cart == true}

    # This needs a project to edit, otherwise redirect_to admin_dashboard
    if ( params[:project_id] != nil )
      @project = Project.find(params[:project_id])
    else
      @project = Project.new
    end

  end

  def post_from_editing_project
    if params[:project_id] == nil
      render :edit_project
      return
    end

    @project = Project.find((params[:project_id]))
    if ( params[:commit] == "Save" )
      @project.update_attributes(:body => params[:project_content])
    else
      @project.update_attributes(:body => @project.body)
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

    @cart= Project.all.select{|p| p.in_cart == true}
    @assigned_students = Student.all.select { |s| s.project_id != nil }
    @students = Student.all.select {|s| s.is_new == true && s.project_id == nil}

  end

  def post_from_assigning_student

    if (params[:student_id].blank?)
      flash[:notice] = "Select a student"
      assign_student
      render :assign_student
      return
    end

    if (params[:project_id].blank? )
      flash[:notice] = "Specify the project that you want to work with first!"
      assign_student
      render :assign_student
      return
    end

    @student = Student.find(params[:student_id])
    @project = Project.find(params[:project_id])

    if ( params[:commit] == "Add" )
      @student.update_attributes(:project_id => @project.id)
    elsif (params[:commit] == "Remove")
      @student.update_attributes(:project_id => nil)
    end

    assign_student
    render :assign_student
  end

  def add_to_project

  end

  def send_emails_to_project_teams

  end

end
