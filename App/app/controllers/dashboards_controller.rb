class DashboardsController < ApplicationController
  # View projects based on project state
  def view

  	# Authenticate user first
  	authenticate_user
  	if (@current_user == nil) || (@current_user.acctype != "coordinator")
  		flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
  		redirect_to :unauthorized
  	end

    # View projects based on project state
    if params[:state].blank?
      @state = "new"
    end

    @state = params[:state]
    @projects = Project.all.select{ |project| project.status == @state }

  end

  # Edit the description of a project
  def project_manip
    # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end

    if params[:id] != nil
      @project = Project.find(params[:id])
      @show_action = params[:show_action]
    else
      redirect_to action: 'view'
    end
  end

  # Assign students to a project
  def edit_details
    # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end

    if params[:id] != nil
      @project = Project.find(params[:id])
    else
      redirect_to action: 'view'
    end

  end

  def update_details
    # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end
    if params[:id] != nil
      @project = Project.find(params[:id])
      if (!@project.update_attributes(project_params))
        render :edit_details
      else
        redirect_to action: "project_manip", id: @project.id
      end
    else
      redirect_to action: 'view'
    end

  end

  def show_message_log
    # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end

    if params[:id] != nil
      @project = Project.find(params[:id])
      @messages = @project.messages
      project_owner = User.find(@project.user_id)
      @email = "#{project_owner.lname}<#{project_owner.email}>"
    else
      redirect_to action: 'view'
    end
  end

  def send_message

    # Authenticate user first
    authenticate_user
    if (@current_user == nil) || (@current_user.acctype != "coordinator")
      flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
      redirect_to :unauthorized
    end

    # Identify the user that owns the project
    @project = Project.find(params[:id])

    recipient = User.find(@project.user_id)
    @current_user = User.find(session[:user_id])

    @message = Message.new(:sender_id=> @current_user.id, :project_id => @project.id, :title => params[:subject], :text => params[:email], :recipient_id =>recipient.id)

    if !@message.save
      render :show_message_log
      return
    end

    file = params[:attachment]
    # Send the message to the user's email
    UserMailer.email_a_message(params[:email], recipient, params[:subject], file).deliver
    flash[:notice] = "Message has been delivered to #{recipient.lname} <#{recipient.email}>"
    redirect_to show_messages_path

  end



  # Any post actions will be handled here
  def action_handler

    # Possible action that change states of a project
    actions = ["Accept", "Suspend", "Reject"]

    # If user has selected a project to apply an action
    if (params[:id] != nil)

      # Find project that has id of :project_id
      @project = Project.find(params[:id])

      # If user wants to change state of project
      if ( actions.include? params[:commit] )
        # Update state of the project
      change_state
      elsif ( params[:commit]=='Remove' )
        # Delete the selected project
        delete
      elsif ( params[:commit]=='Send')
        # Send a message to the selected project
        if (params[:subject] == "" || params[:email]=="")
          flash[:notice] = 'Subject or message fields are missing!'
        else
          send_message
        end
      elsif ( params[:commit]=='Add To Cart' )
        @project.update_attributes(:in_cart => true)
      elsif ( params[:commit] == 'Save')
        @project.update_attributes(:body => params[:project_content])
        redirect_to edit_desc_path
        return
      elsif (params[:commit] == 'Project Description')
        @des = true
        @log = false
      elsif (params[:commit] == 'Message Log')
        @message_log = @project.messages
        @des = false
        @log = true
      end
    else
      flash[:notice] = 'Please select a project first!'
    end

    # Anyway, just render the same page
    view
    render :view

  end

  private


    # Change state of a project
    def change_state
      # Changed state corressponding to action
      changed = {'Accept' => 'accepted', 'Suspend' => 'pending', 'Reject' => 'rejected'}
      @project.update_attributes({:status => changed[params[:commit]]})
    end

    # Update description of a project
    def update_desc
    end

    def compare_date(before, after)
      before = before.split("/")
      after = after.split("/")
      before[2] + " " + before[1] + " " + before[0] >= after[2] + " " + after[1] + " " + after[0]
    end

    def delete
      Project.destroy(params[:id]);
    end

    def project_params
      params.require(:project).permit(:title, :body, :attachment, :compl_time, :languages, :system_req, :compat_req, :student_req_lang, :student_req_concepts, :student_police_check, :student_security, :extra_details)
    end

end
