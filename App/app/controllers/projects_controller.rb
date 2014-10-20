class ProjectsController < ApplicationController

  def index
    @projects = StudentProject.all
    
    #get the filter year and category data
    @year=params[:year]
    @category=params[:category]
  end

  def new
    # @students = Student.all
    @student_project = StudentProject.new
    @student = Student.new
    3.times { @student_project.students.build }
  end

  def create
    @student_project = StudentProject.new(project_params)
    if @student_project.save
      redirect_to :index, :notice => "Project created"
    else
      redirect_to :new
    end
  end

  def project_params
    params.require(:student_project).permit(:title, :summary, :image, :client, :client_image, :category, :year, students_attributes: [:id,:name, :email, :studentID, :course])
  end

  def show
    #get the project's ID here
      @ProjectID = params[:id]
      @Projects = StudentProject.all

      #get the specifc project
      @theProject=@Projects.find(@ProjectID)
      #get all students worked in this project
      @students=@theProject.students.all

      #go to 404 page if project cannot be found
      rescue ActiveRecord::RecordNotFound
        redirect_to "/404"
  end

     
    def edit
       if session[:user_id] != nil
          @user = User.find(session[:user_id]) 
        if @user.acctype == "coordinator" 
      #get the project's ID here
      @ProjectID = params[:id]
      @Projects = StudentProject.all

      #get the specifc project
      @theProject=@Projects.find(@ProjectID)
      #get all students worked in this project
      @students=@theProject.students.all
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
                                                          
    	#get the updated project ID
    	if params[:id] !=nil
                                                                                                                                                                                                                                                                                                                                                                                  
      		@updateProject=StudentProject.find(params[:id])
     		 #get all students worked in this project
      		@students=@updateProject.students.all
      
     		 #update the attributes without save to DB yet
      		@updateProject.attributes=project_params
      		#save to DB      	
      	   	@updateProject.save
      		#check if there any change
      		#if @updateProject.changed? ==false 
      		#	 flash[:notice] ="There is no any change, please edit again"
         	#	redirect_to :edit
      		#else

      		#end      
    	end                                                                                                                                                                                                        
  end

def unchanged
end

def destroy
    if session[:user_id] != nil
          @user = User.find(session[:user_id]) 
        if @user.acctype == "coordinator" 
         	 #get the project's ID here
 	 	@ProjectID = params[:id]
      	@Projects = StudentProject.all

  		#get the specifc project
  		@theProject=@Projects.find(@ProjectID)
  
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
  if params[:id] !=nil
     StudentProject.destroy(params[:id])
  end
end

def addstudent
        if params[:id] != nil
                  @theStudent = Student.new
                  @theProject= StudentProject.find(params[:id]) 
         end                                                                                                                                                                                              
end
                                                                                                                                                                                                      


  def addstudent_create
     @student = Student.new(student_params)
    if @student.save == false
      flash[:notice] = "Invalid Input"
      redirect_to student_new_path
       end
   end

def info
end

def contact
end

def search                                                                                                                                                                                                
         #redirect to student's search funtion  if related classify is selected
        if (params[:classify].downcase=="name" )|| (params[:classify].downcase=="student id" ) || (params[:classify].downcase=="course" ) || (params[:classify].downcase=="email" )
                 redirect_to  student_search_path(:classify=>params[:classify], :search=>params[:search])                                                                                                                                                                                              
       else    

       #fetch the searhed results here                                                                                                                                                                                                
      @searchVariable = StudentProject.search(params[:classify], params[:search])
      #handle empty search
      if @searchVariable.blank?
                 redirect_to  action:'notfound'                                                                                           
      end  
      end         
end         
 
def notfound 
                                                                                                   
end                                                                                         
                                                                                 
end
