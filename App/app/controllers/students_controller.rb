class StudentsController < ApplicationController
	def new
		if session[:user_id] != nil
			@user = User.find(session[:user_id])
			if @user.acctype == "coordinator"
				# @students = Student.all
				@theStudent = Student.new

			else
				flash[:notice] = "Please Login as a coordinator to edit a past project"
				redirect_to :login
			end
		else
			flash[:notice] = "Please Login to edit a past project"
			redirect_to :login
		end

	end

	def create
		if session[:user_id] != nil
			@user = User.find(session[:user_id])
			if @user.acctype == "coordinator"
				#add the new student to pastProjects
				@theProject= StudentProject.find(params[:id])
				@save=@theProject.students.new(student_params)
				if @save.save == false
					flash[:notice] = "Some input fields are invalid, please check and submit again "
					redirect_to student_new_path
				end
			else
				flash[:notice] = "Please Login as a coordinator to edit a past project"
				redirect_to :login
			end
		else
			flash[:notice] = "Please Login to edit a past project"
			redirect_to :login
		end
	end

	def delete
		if session[:user_id] != nil
			@user = User.find(session[:user_id])
			if @user.acctype == "coordinator"
				if params[:id] !=nil
					#get the project id before destory
					@projectID= Student.find(params[:id]).student_project_id

					Student.find(params[:id]).destroy

					redirect_to edit_path(@projectID)
				end
			else
				flash[:notice] = "Please Login as a coordinator to edit a past project"
				redirect_to :login
			end
		else
			flash[:notice] = "Please Login to edit a past project"
			redirect_to :login
		end
	end

	def edit
		if session[:user_id] != nil
			@user = User.find(session[:user_id])
			if @user.acctype == "coordinator"
				if params[:id] !=nil
					#@s=Student.find(params[:id]).update(student_params)
					#@s.save
					@theStudent=Student.find(params[:id])
				end
			else
				flash[:notice] = "Please Login as a coordinator to edit a past project"
				redirect_to :login
			end
		else
			flash[:notice] = "Please Login to edit a past project"
			redirect_to :login
		end
	end

	def update
		if session[:user_id] != nil
			@user = User.find(session[:user_id])
			if @user.acctype == "coordinator"
				if params[:id] !=nil
					@theStudent=Student.find(params[:id])
					#update the attributes without save to DB yet
					@theStudent.attributes=student_params

					#check if there any change
					if @theStudent.changed? ==false
						flash[:notice] ="There is no any change, please edit again"
						redirect_to student_edit_path(params[:id])
					else
						#save to DB
						@theStudent.save
					end
				end
			else
				flash[:notice] = "Please Login as a coordinator to edit a past project"
				redirect_to :login
			end
		else
			flash[:notice] = "Please Login to edit a past project"
			redirect_to :login
		end
	end

	def student_params
		params.require(:student).permit(:name, :email, :studentID, :course)
	end

	def search
		#take in the searching params here
		@search=params[:search]
		@classify=params[:classify].downcase

		#define a project that will be searched
		@searchedProject=nil

		@students=Student.all
		@StundentProjects=StudentProject.all

		#traverse each student column fields here
		if @classify=="name"
			#if found, return the searched project by student_project_id
			@find=@students.find_by_name(@search)
			if @find.blank? == false
				@searchedProject=@StundentProjects.find(@find.student_project_id)
			else
				redirect_to :notfound
			end

		elsif @classify=="student id"
			#if found, return the searched project by student_project_id
			@find=@students.find_by_studentID(@search)
			if @find.blank? == false
				@searchedProject=@StundentProjects.find(@find.student_project_id)
			else
				redirect_to notfound_path
			end
		elsif @classify=="email"
			#if found, return the searched project by student_project_id
			@find=@students.find_by_email(@search)
			if @find.blank? == false
				@searchedProject=@StundentProjects.find(@find.student_project_id)
			else
				redirect_to notfound_path
			end

		#many students may have the same course here, so the studentProject is not just one here
		elsif @classify=="course"
			#if found, return all students taking this course rather than return the specific project here
			@finds=@students.where("course = ?",  @search)
			if @find.blank? == true
				redirect_to notfound_path
			end
		end
	end

	def notfound
	end
end
