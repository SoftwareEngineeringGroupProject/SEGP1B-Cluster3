class DashboardsController < ApplicationController
  # View projects based on project state
  def view

  	# Authenticate user first
  	authenticate_user
  	if (@current_user == nil) || (@current_user.acctype != "coordinator")
  		flash[:notice] = "You have an Industry Partner Account, NOT a Coordinator account."
  		redirect_to :unauthorized
  	end

    # Define how to display the white board, either display description or message log
    @des = !@log

    # View projects based on project state
    @state = params[:state]
    @cart = Project.all.select{|p| p.in_cart == true}

    params[:date] = "02/12/1995" if params[:date] == "Filter by date" || params[:date] == nil

    @projects = Project.all.select{|project| project.status == @state && compare_date(project.created_at.strftime("%m/%d/%Y"), params[:date] ) }

    # Create a hash containing emails of all company, this is then used in view
    # to show the corresponding email of a project  when we select that project
    @emails = {}
    User.all.each do |user|

      if user.acctype == "industry"
        @emails[user.id] = "To: #{user.lname} <#{user.email}>"
      end

    end
  end

  # Edit the description of a project
  def edit_desc
    authenticate_user
    @cart = Project.all.select{|p| p.in_cart == true}

    if params[:id] != nil
      @project = Project.find(params[:id])
    else
      @project = Project.new
      @project.body = "Please select a project to edit..."
    end
  end


  # Assign students to a project
  def assign_students
    authenticate_user

    @cart = Project.all.select{|p| p.in_cart == true}
  end

  # Any post actions will be handled here
  def action_handler

    # Possible action that change states of a project
    actions = ["Accept", "Suspend", "Reject"]

    # If user has selected a project to apply an action
    if (params[:project_id] != nil)

      # Find project that has id of :project_id
      @project = Project.find(params[:project_id])

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

    def send_message
      # Identify the user that owns the project
      recipient = User.find(@project.user_id)

      @current_user = User.find(session[:user_id])

      @message = Message.new(:sender_id=> @current_user.id, :project_id => @project.id, :title => params[:subject], :text => params[:email], :recipient_id =>recipient.id)

      if !@message.save
        return
      end

      file = params[:attachment]
      # Send the message to the user's email
      UserMailer.send_a_message(params[:email], recipient, params[:subject], file).deliver
      flash[:notice] = "Message has been delivered to #{recipient.lname} <#{recipient.email}>"

    end

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
      Project.destroy(params[:project_id]);
    end

end
