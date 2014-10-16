include ActionView::Helpers::AssetTagHelper
class ProjectsController < ApplicationController

  def index
    @projects = StudentProject.all
    # @groups = Group.all
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
    params.require(:student_project).permit(:title, :summary, :image, :client, :client_image, :category, :year, students_attributes: [:name, :email, :studentID, :course])
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

  # def edit

  #  if session[:user_id] != nil
         #get the project's ID here
     #    @ProjectID = params[:id]
        # @Projects = StudentProject.all

         #get the specifc project
         #@theProject=@Projects.find(@ProjectID)
    #else
       #  flash[:notice] = "Please Login to edit a past project"
         #redirect_to :login
    #end

  #end
     
    def edit
      #get the project's ID here
      @ProjectID = params[:id]
      @Projects = StudentProject.all

      #get the specifc project
      @theProject=@Projects.find(@ProjectID)
      #get all students worked in this project
      @students=@theProject.students.all
      
          # the function is used to create a new student record if a Student project does not have one student ,
    #which helps form input to show an empty input line in edit page                                                                                           
             
    end

  def update
                                                          
    #get the updated project ID
    if params[:id] !=nil
                                                                                                                                                                                                            
                                                                                                                                                                          
      @updateProject=StudentProject.find(params[:id])
      #get all students worked in this project
      @students=@updateProject.students.all
      
            #check if a student is deleted or created

       #update the attributes without save to DB yet
      @updateProject.attributes= project_params
      
      #save to DB here
      @updateProject.updated_at=Time.now
       @updateProject.save    
        
    end                                                                                                                                                                                                        
  end

def unchanged
end

     #def destroy

        #  if session[:user_id] != nil
           #    #get the project's ID here
              # @ProjectID = params[:id]
              # @Projects = StudentProject.all

               #get the specifc project
              # @theProject=@Projects.find(@ProjectID)
          ##  flash[:notice] = "Please Login to edit a past project"
             #  redirect_to :login
          #end
    # end
def destroy

  #get the project's ID here
  @ProjectID = params[:id]
  @Projects = StudentProject.all

  #get the specifc project
  @theProject=@Projects.find(@ProjectID)
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
      @searchVariable = StudentProject.search(params[:classify], params[:search], params[:date]["year"].to_i)
      @a=params[:date]["year"].to_i
      #handle empty search
      if @searchVariable.empty?
                 redirect_to  action:'notfound'                                                                                           
      end  
      end         
end         
 
def notfound 
                                                                                                   
end                                                                                         
                                                                                 
end
